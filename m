Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CB76408A9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiLBOok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiLBOog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:44:36 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08896C2D3B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 06:44:36 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so5343915pjm.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 06:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xXbytbP1/ePNTxS00CmWdm3iawFnjBrPNYN7pKpfhj8=;
        b=kr7CWXx9ix1/9zPbl4myGkgdkVpkUYV/dZSApE+bje+eFiyFXJAbdFa+pLc0Ws5fnX
         sgLv1Hkl+8tHV9kwaOTr3yR6yVVGbxLNmDZwl/yI+JUHLWoYSpHnPkNN0rJHfDLtaj1s
         AOeTXDAAflG+dHp2uw7hN1Pk9gRMn1Fc+76mUtv1ZfpbQpxdPD6fdsGmRqdyQFgC89JL
         8X4wEy9Rf34YUCctmHGL+WXBBWpzY8nfYjKaV5kxxhnMCtlBlj/tv1sLkIDEpts4KA5R
         nX5SuEwLufrRGBLjth3aGilMeqn2SqsdlALS5ZQjwh+GNxh2Ml/c3SvKJxf4mPSC5Kq1
         W57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXbytbP1/ePNTxS00CmWdm3iawFnjBrPNYN7pKpfhj8=;
        b=8EdQ+TjuoumpDJobpOMdm5gLpVY2ED7NHgtVcUS9RoLSJBc3ay8MV26soR0oTVamoZ
         thDxfM/bydJYT+KYJwZs8qmJGPrQKEoX4epVsP4qrz8HuGuyp4Fl+JFjkTOLjAa6zGrp
         nvfFjaaTHHziQM4EKDqZ7hlrIHL2d68a3A9YXDeTqk8Sxk0sjGTZ9ONOV0ECaEZNz95q
         iW7UHomYvAKg7u70DPGaJxFaMn4zlPVEoU6/dvGYJ+0XmOcI8+519znyLHkaV6zSULPU
         aruUjsD1N5uYcOrglS2W+iMf7tYz3Fppn4z/+i4of/BFlO2yg8IeVDYih0AasBjPTfRf
         tYaQ==
X-Gm-Message-State: ANoB5pkuEGtPYKFZTY+cdTTeIyUFKjISWLKrDPJAkPrDYfb5W72wKxyJ
        fy+MBLWZuCeOUO/G3Y03IYE=
X-Google-Smtp-Source: AA0mqf7YrukURYuRplHph9ujG+j5wVdhdeuTb5cDsQlPq9Ny3NRU+5J10/D0E4jDOmpEPBvMGW3YmQ==
X-Received: by 2002:a17:90a:a588:b0:218:8eb8:8502 with SMTP id b8-20020a17090aa58800b002188eb88502mr68748312pjq.179.1669992275467;
        Fri, 02 Dec 2022 06:44:35 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id z5-20020aa79585000000b005764a143be3sm1876985pfj.103.2022.12.02.06.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 06:44:35 -0800 (PST)
Message-ID: <f7387ceb-7b8f-0713-cb2e-a5d3b21bfb6a@gmail.com>
Date:   Fri, 2 Dec 2022 23:44:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] tools: memory-model: Make plain accesses carry
 dependencies
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        paulmck@kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20221202125100.30146-1-jonas.oberhauser@huaweicloud.com>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20221202125100.30146-1-jonas.oberhauser@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Dropping most CCs]

Hi Jonas,

A comment on the way this patch was sent.

On Fri,  2 Dec 2022 13:51:00 +0100, Jonas Oberhauser wrote:
> From: Jonas Oberhauser <jonas.oberhauser@huawei.com>

The sender of this patch reads
     "Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>".

Is there any technical reason you've sent this patch in this way?

        Thanks, Akira

[...]
