Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD8A7000E9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 08:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbjELGyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 02:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239890AbjELGyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 02:54:31 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA31B7685;
        Thu, 11 May 2023 23:54:30 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1aad5245571so66599305ad.1;
        Thu, 11 May 2023 23:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683874470; x=1686466470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YYafEsAf/ICL7imy+wUUO3PaRUVNMMw7knDTFl4MjVs=;
        b=Aj8qULTX92MOZTOHD9zYDBy4KoBnmA2/2dnrK28uF1SxcM7ipCyCqL17uPhsoICsf3
         CqeIVw2iRPcUE5wgLm4N933gBdMiEplKLll7GmQiL3UiJsJa9EvntfXF2QB6vJd7dmUw
         1uQCnqYorxHxXeUf9IIo3NfDpj/ExJRSbqpiGoMU+M7a2ZOUwCIKySS23YqvAdF4ypml
         +tX8/vjK+5RDCnL/sFX9XXmG2wgP27M0MAajcZ4QMto+z2eeoAS5ezYIDW8Y37S7l6oD
         d89m3Dbbdr+SAxsSEQx3AUtJNFbSCONE7RDqqXJiPF7n1zmbyghWN3uwk4WDFR/98r9p
         0Wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683874470; x=1686466470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYafEsAf/ICL7imy+wUUO3PaRUVNMMw7knDTFl4MjVs=;
        b=Q/Z+1C9slMS4oIFI+D7MgyeFIK4bgJJH/yxlEcvhwlokQpSxMMZvNx0YdoceXn3MQJ
         /SYnY+RJQP+iC1n9yQMQljpVbsPV00x2QWgGF32HQ5zuCsB09On30s7AtjJAQeUXZpVq
         T55ddfrH8rJv2LxF+Jv0wME18GxqSSpucMW3fDv3sTxAq0rEw/1OD4iuQFTVrdYsUNEO
         gHRG038XxdLVBhvdAZvykesodAh69KKB6wh/wiH1jzP4etoeAlErlNV+bAyG8yhJKUBD
         jx73f9neuszGvb2mNResvz2nGbg56VXVgcOXLSZt5peAjYIc4EUtxX3q+5bzanAmkiJP
         aJ4A==
X-Gm-Message-State: AC+VfDybVdit0rHkyL7Z2WKkHyXSTRZ/sMaV5VWoXx/jeeUQhAsCPs7J
        aHqikuVm8b2a3cUTWlpCMLywf63g6yx2/gCxUgw=
X-Google-Smtp-Source: ACHHUZ6t06JM6TCUADoa/v9MGVHz0yJBE8RLM7yDrJ4D9JFyOjATgBOYfV5jJQH1oyiDrWCoC1ZNC3nuof9BF7pze0s=
X-Received: by 2002:a17:902:d2c9:b0:1ac:61ad:d6bd with SMTP id
 n9-20020a170902d2c900b001ac61add6bdmr23405542plc.65.1683874470106; Thu, 11
 May 2023 23:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230511135632.78344-1-bstruempfel@ultratronik.de>
 <20230511231317.158214-1-bstruempfel@ultratronik.de> <20230511231317.158214-2-bstruempfel@ultratronik.de>
 <ZF2y1YNkSbXzRm4V@finisterre.sirena.org.uk>
In-Reply-To: <ZF2y1YNkSbXzRm4V@finisterre.sirena.org.uk>
From:   =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>
Date:   Fri, 12 May 2023 08:54:19 +0200
Message-ID: <CAEktqcthEG=AWTk9VcVkwexH6xV_xHw1hqxkkPkD=d1NqPKqSg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] spi: dt-bindings: Introduce spi-mosi-idle-low flag
To:     Mark Brown <broonie@kernel.org>
Cc:     bstruempfel@ultratronik.de, andy.shevchenko@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr., 12. Mai 2023 um 05:30 Uhr schrieb Mark Brown <broonie@kernel.org>:
>
> On Fri, May 12, 2023 at 01:13:14AM +0200, Boerge Struempfel wrote:
> > Some spi controller switch the mosi line to high, whenever they are
> > idle. This may not be desired in all use cases. For example neopixel
> > leds can get confused and flicker due to misinterpreting the idle state.
> > Therefore, we introduce a new spi-mode bit, with which the idle behaviour
> > can be overwritten on a per device basis.
> >
> > Signed-off-by: Boerge Struempfel <bstruempfel@ultratronik.de>
> > ---
> >  .../devicetree/bindings/spi/spi-peripheral-props.yaml       | 6 ++++++
>
> If this is always required for a given device (which I'd expect to be
> the case) why configure it through DT?  I know we've got some legacy
> stuff like that but not all legacy DT choices were good and no need to
> continue the pattern.

Yes this will always be the case for specific spi-device, spi-controller
combinations. Just to make sure, that I understand your suggestion
correctly: You propose to check from the specific spi-device-driver, if
the spi-controller supports this particular mode-bit, and then set it if
it does and thereby loose the need for the DT entry completely?
