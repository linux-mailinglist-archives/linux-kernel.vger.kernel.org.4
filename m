Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2926EA453
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjDUHHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjDUHHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:07:38 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D325176AA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:07:33 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51f6461af24so1466647a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682060853; x=1684652853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/EyNyMkMmf3c5UaL2zyKeEONRIDEFfdRGCHlb99q+wk=;
        b=RyHAWIe/3v1kwY/5oI244lQ8DzPGu99DpVgKBhC6+r+SqzRodbUWlryOoUo26yWerX
         14kI5eOe21GTCE/gpvODPrp3GE/Sipc802EIOUeeZ0Arcev28r2NveChEanP91C0KvyS
         1bWlHUqGczSY/dUo+WfL33CncbqDAOGeS5AcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682060853; x=1684652853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EyNyMkMmf3c5UaL2zyKeEONRIDEFfdRGCHlb99q+wk=;
        b=Qs3eDu2WYxvuIQXjLdJK3dOmDavkw0ahkaT4GK6ZSAwSxuH6jaHJ0lgkPjapGgUsXh
         dm/mdjFWCXTW8CI1hKS+UUpKcZKjfuglPAt4ZyW7WS+jImNYumTkIAjSxB3Gslv/ZgUX
         FJvDtFf6YOgfPDgKAVZ0wciN7FH8s8ESsBXlH3W8pEgSjeF9rSyzklTNK07eql/L7VoB
         b80e/iqeFHL8zHnytEkpA6C4e8+V39kyEePRwO6HxCqsgIjrc+WIt7gcVfIJp9HZrkz/
         miIq/PqTXVVhF30k0kMG/q4jQY8QxmpU5oi/dkVi/vPXSw9pJaGsJXRA8dSAAfqutRdO
         oFtQ==
X-Gm-Message-State: AAQBX9eyQ0Ub/IKz+v6L5OGlKqSeP3Iup6Hvf9IBpEDm1plOm23R5erM
        /fqz4h6TwEeNr6pbIC20Z5rcMQ==
X-Google-Smtp-Source: AKy350bdO66K0sz0qBhpj/XfmcB3Odsfj8G+4yIItrA41fd3ENYF+dtB0Ubo2/rImUfn+SLGlh77tA==
X-Received: by 2002:a17:90b:1c87:b0:24b:2b9a:7fd2 with SMTP id oo7-20020a17090b1c8700b0024b2b9a7fd2mr4022778pjb.9.1682060853248;
        Fri, 21 Apr 2023 00:07:33 -0700 (PDT)
Received: from ?IPV6:2401:fa00:8f:203:8d5b:baf3:7d4d:ff96? ([2401:fa00:8f:203:8d5b:baf3:7d4d:ff96])
        by smtp.gmail.com with ESMTPSA id w13-20020a17090a460d00b002470f179b92sm3883614pjg.43.2023.04.21.00.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 00:07:32 -0700 (PDT)
Message-ID: <0ed5d350-85f6-967f-5ff9-270e50bb0f3a@chromium.org>
Date:   Fri, 21 Apr 2023 16:07:29 +0900
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
From:   Max Staudt <mstaudt@chromium.org>
In-Reply-To: <20230414072419.1397808-1-mstaudt@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Is this patch close to what you had in mind when you suggested updating 
the simulated webcam parameters in vivid?



Thanks,

Max

