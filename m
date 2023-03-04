Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D486AA840
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 06:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCDF70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 00:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDF7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 00:59:24 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0492113F3;
        Fri,  3 Mar 2023 21:59:22 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id g3so18532495eda.1;
        Fri, 03 Mar 2023 21:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZdOR2mQrM2Yh/ZdXBDU9hVL0HlZsZVueh/CEeqYueU=;
        b=Spc5p3ovs3CEvWjvB15Lsxi3xGjMUIlNSYNFAcggChHEqyh1XQIV3ghzRysFCQdwot
         B+Pzk25ozrx9jxO/cugIqFD/r06/RjYzQnBpUsHfl/0KYoxab8FIKN/6rnu8co2Z7lxk
         Mz/CVbIsMog2abpNbYK7pFe96zz3t3Rm2GralvuU2HiegQXFXYRGe79tiCnlqDK3Rrl6
         8VS8m3lEou653ypRcub4hORgngyVE/4CfwaI/6Ymv9PPP20xwlEC+gP0A5TBq1L9JjQx
         WqrbysUxMMTh2VK+L+GDogxIkZBJXxBrm5+58547IY4AFuOrd0rJYXORJ4HKz5lJfuqe
         f6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZdOR2mQrM2Yh/ZdXBDU9hVL0HlZsZVueh/CEeqYueU=;
        b=1MuB48RNZVENhO0ftSViFZkYdobpOJHd8Ci6EpOVOC3LpyOnWFXT/qKLL2gebV4/bW
         dFH2fwgSmMUq2juKuEfgHz+42srJOKsAB2WaXKouKFPnFtqDpXQCxwBo2HWQo0LIG9md
         6iLV/8TZMK5Box7rVwLNujUmNNumYDx1bXaKGjabrJQbWn5pHOVcIMQwLQoyCRgMKKoz
         8PN5nH8dD923YrSJ/pnjh1u1Fu9MpkDf4tZSeV2tGbozbHjkyMX1Xmzgr6EvyHoTfH2Y
         KfSWMfftRUn9Ha7eroXJMeQQHYw4n4SNpybYlX/Tm1DSId/L+GP8TgImDMoEGdReuFUA
         nJhw==
X-Gm-Message-State: AO0yUKVTsG+fgkgOFehh299C4C537/Gx2y0C6Sb20RvMoyupXQAptkzT
        i5eAWqtEjX9OOMcOkR0UXPs=
X-Google-Smtp-Source: AK7set8UXUFWR2ui/AgXkHFAvLBJPzNPX6LhnlTox4YZzu7Cyy9qpwNmgZWB6VYga3nqRk1K4I90aA==
X-Received: by 2002:a05:6402:510:b0:4bb:83fa:5e83 with SMTP id m16-20020a056402051000b004bb83fa5e83mr4125414edv.12.1677909561087;
        Fri, 03 Mar 2023 21:59:21 -0800 (PST)
Received: from [192.168.0.173] ([79.115.63.78])
        by smtp.gmail.com with ESMTPSA id v12-20020a50c40c000000b004bb810e0b87sm2030841edf.39.2023.03.03.21.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 21:59:20 -0800 (PST)
Message-ID: <5bd48f09-f7ba-e5b3-60ba-49ecd1493e36@gmail.com>
Date:   Sat, 4 Mar 2023 07:59:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] spi: Replace `dummy.nbytes` with `dummy.ncycles`
To:     Sergiu Moga <sergiu.moga@microchip.com>, pratyush@kernel.org,
        michael@walle.cc, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, broonie@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        chin-ting_kuo@aspeedtech.com, clg@kaod.org, joel@jms.id.au,
        andrew@aj.id.au, kdasu.kdev@gmail.com, fancer.lancer@gmail.com,
        han.xu@nxp.com, john.garry@huawei.com, matthias.bgg@gmail.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        haibo.chen@nxp.com, yogeshgaur.83@gmail.com, heiko@sntech.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        michal.simek@xilinx.com, tkuw584924@gmail.com,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        tudor.ambarus@linaro.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20220911174551.653599-1-sergiu.moga@microchip.com>
From:   Tudor Ambarus <tudor.ambarus@gmail.com>
Content-Language: en-US
In-Reply-To: <20220911174551.653599-1-sergiu.moga@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sergiu changed his interests, I'm going to send a new version of this
patch. We really need the conversion in SPI NOR as there are flashes
that require a number of dummy cycles that is not multiple of 8.

Cheers,
ta
