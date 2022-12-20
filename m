Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6106527CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiLTUWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbiLTUV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:21:59 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C084CB65;
        Tue, 20 Dec 2022 12:21:58 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id j4so20407870lfk.0;
        Tue, 20 Dec 2022 12:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uem/Rg0y7RK0QKRnhhb+pOTt6PVpCehNtdD/fJMouvo=;
        b=n2RYVym0j++xBdJtTs4jg7kJ6kCMuuFIVQy8UMoq3D3cChxpobhm4EnaHRumBO3T6c
         n8HhrHZRe6UaO7eYyTBwSlP+0mkd4ZkkKAb1TZx/TfXAAGhKnHcrXg3m1kSycklnNo8b
         OYuVVUb8eF4pBTGpvfC8YHlV+JPyUDc7YY9txn0/p/KOaz/Nfuej9WaP0d2ieVWP/Pf0
         ml1amYkOw92Z9rXLpnTeq+ch/Rs9y6Y/naGXrsq0C2acTynwGu7WQazalH8yD4seB8Dq
         XBPBak24O5Fmxfzm2tZTu5f/Qn3HKJKxIpGAEW0I1gDMA2K7tRMhy8/X28gncf44dScD
         QZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uem/Rg0y7RK0QKRnhhb+pOTt6PVpCehNtdD/fJMouvo=;
        b=JUdZycBe5lSiRgFJfd06p+mYoE78QalskZnk9UjlNXuMrIF3oHfXTjrIOBUu2W9xJi
         0CoI/rOMjfGgIZdZ52BQLznp60nyu/DDuZn5fY5GhdO7mWgtgHTiyacHqQ7R7+zbel6a
         4m+7AMOdb8of1SR9kgCaFzG+Ru0S7wccy2kP+2mJdvCD/H3lS6qzWCE/ma3HfxfrdlXo
         McatsN1aHZoBwS8Bno9zltr2X3eRfYdXybrEMApmlyFamKQIYne13IxBrqO1s4yAb+Ws
         j5A/NvhZctP/hYBtvdhw6ZGxIhwznYQ/wa0oZ4f6X6BywcuXdP73nuUJnr5zTUJnbZTl
         Jv7A==
X-Gm-Message-State: ANoB5pnyFW71NdJLeTJFyjK19gCrB9pM70Sile3v+cfPIKkNEk6qTFCN
        HgKA//sFBjPxtV2hqvOl7Hc=
X-Google-Smtp-Source: AA0mqf50xiaxLBBtKZY+3R63yU+WhzuT/XVOd54mJpdrGz3UjV0WgTPmLiUveiXcBdAvF7VTtc3LxA==
X-Received: by 2002:a05:6512:260c:b0:4b5:8e1e:867b with SMTP id bt12-20020a056512260c00b004b58e1e867bmr16677059lfb.59.1671567717063;
        Tue, 20 Dec 2022 12:21:57 -0800 (PST)
Received: from [192.168.2.145] (109-252-113-89.nat.spd-mgts.ru. [109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id s1-20020a19ad41000000b004b59c9b7fb4sm1573738lfd.126.2022.12.20.12.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 12:21:56 -0800 (PST)
Message-ID: <a99fa7e5-31bc-4286-17e5-6ba6e4932bcf@gmail.com>
Date:   Tue, 20 Dec 2022 23:21:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 00/21] Add Tegra20 parallel video input capture
Content-Language: en-US
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
References: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

28.11.2022 18:23, Luca Ceresoli пишет:
> Tegra20 and other Tegra SoCs have a video input (VI) peripheral that can
> receive from either MIPI CSI-2 or parallel video (called respectively "CSI"
> and "VIP" in the documentation). The kernel currently has a staging driver
> for Tegra210 CSI capture. This patch set adds support for Tegra20 VIP
> capture.
> 
> Unfortunately I had no real documentation available to base this work on.
> I only had a working downstream 3.1 kernel, so I started with the driver
> found there and heavily reworked it to fit into the mainline tegra-video
> driver structure. The existing code appears written with the intent of
> being modular and allow adding new input mechanisms and new SoCs while
> keeping a unique VI core module. However its modularity and extensibility
> was not enough to add Tegra20 VIP support, so I added some hooks to turn
> hard-coded behaviour into per-SoC or per-bus customizable code. There are
> also a fix, some generic cleanups and DT bindings.
> 
> Quick tour of the patches:
> 
>  * Device tree bindings and minor DTS improvements
> 
>    01. dt-bindings: display: tegra: add Tegra20 VIP
>    02. dt-bindings: display: tegra: vi: add 'vip' property and example

This series adds the new DT node, but there are no board DTs in upstream
that will use VIP? Will we see the board patches?

In any case, given that you're likely the only one here who has access
to hardware with VIP, you should promote yourself to the tegra-video
driver maintainers and confirm that you will be able to maintain and
test this code for years to come.

