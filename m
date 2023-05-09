Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ABC6FBF26
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjEIGRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjEIGRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:17:17 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E074AD33
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:16:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64388cf3263so3845292b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 23:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683613014; x=1686205014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KpJaIz3n6YfBt1BgXIis7ST4Ql6IKJLHHnYjq/P8RNM=;
        b=KqL/LQGeEMEB9EoP5Xo6ngLe6eTx7ya8Qj05QNd3K9OgMu3i+2ViejklL8vnoMP0j7
         24ASHnwYmxZjOLTA827LqLHp9ce4AN/iR49wTC/D3wVFOsqgMtUxstjMsSECVcuiwgie
         knPfurV0c31riNhHO1KUXqg6/9wbv9kusoY3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683613014; x=1686205014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KpJaIz3n6YfBt1BgXIis7ST4Ql6IKJLHHnYjq/P8RNM=;
        b=jcAWUVtc0v2mGGo4S6CGlaAAm5eeClb6QRJ2l6m0/fLfGjlw6CFDpDPG6kuG70qeSc
         YrIxIa+rI5Oi/qqX9dF3U2a1BkRU0WsAbHUJ2tEfpajgoUohO6dGWiQgDgYNRSZHWMT2
         y0EcCI0pYOXuu8j0uBjpZhPosGOSIvj4s0WCHrMeA4ShOYPB3A/tz/kuDKMmM5v87TtF
         Q9mKbDWW5/ANta0ENE8VtfjWO+ROPEK3v8h7DUA/VV4LVBMtE5SXeUj1yxjvLzHAyfea
         kKdeiQnSwtTi4KhQ7A78TZpjgIaxNDaGmxja/0HYDfchx3GRzD6UI6JKvpfIzSE7hrvl
         DOBg==
X-Gm-Message-State: AC+VfDxIERXbBb+7tAav+O0qboKhM+Y3oGk+aDN15eB8S0JbuQw7o5AN
        MEtK1xmCv4WuOUsNVVt8H5aGDQ==
X-Google-Smtp-Source: ACHHUZ6qvhHvdGnzORfyn+gcdXecouICVy5rSmpqaS84Co8P15l4QdWcrEIV5ghh3WSGhXEf9iJYXQ==
X-Received: by 2002:a05:6a20:258d:b0:ff:ef11:d20 with SMTP id k13-20020a056a20258d00b000ffef110d20mr10784488pzd.30.1683613014449;
        Mon, 08 May 2023 23:16:54 -0700 (PDT)
Received: from ?IPV6:2401:fa00:8f:203:5b49:c0b4:4f69:b76c? ([2401:fa00:8f:203:5b49:c0b4:4f69:b76c])
        by smtp.gmail.com with ESMTPSA id r19-20020a62e413000000b0062d859a33d1sm954475pfh.84.2023.05.08.23.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 23:16:54 -0700 (PDT)
Message-ID: <aee557db-a6a7-a7f5-49f2-2f62c84ff2c3@chromium.org>
Date:   Tue, 9 May 2023 15:16:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1] media: vivid: Extend FPS rates offered by simulated
 webcam
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>
References: <20230414072419.1397808-1-mstaudt@chromium.org>
 <0ed5d350-85f6-967f-5ff9-270e50bb0f3a@chromium.org>
 <e0dd9182-0638-b616-d09b-a2b031513c19@xs4all.nl>
 <310b789c-ae2e-7306-267e-8bf508211b60@chromium.org>
 <bd58506f-1eb1-d0f4-4145-95dbbd821807@xs4all.nl>
From:   Max Staudt <mstaudt@chromium.org>
In-Reply-To: <bd58506f-1eb1-d0f4-4145-95dbbd821807@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 15:14, Hans Verkuil wrote:
> On 09/05/2023 07:09, Max Staudt wrote:
>> Are you still interested in upstreaming an updated FPS table?
> 
> Yes. I've been very busy, so it will take some time before I pick it up, but it
> should go in for the 6.5 kernel.

Thanks for the quick reply, and looking forward :)


Max

