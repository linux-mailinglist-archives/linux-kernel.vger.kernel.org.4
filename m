Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECD2675EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjATUaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjATUaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:30:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9590981988;
        Fri, 20 Jan 2023 12:30:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44494B82A57;
        Fri, 20 Jan 2023 20:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C82C433EF;
        Fri, 20 Jan 2023 20:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674246612;
        bh=MzyLhaguD/F2KdfK/Rr4D39zLsYoYhgkuTcjE6eMGy8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JFSssLD6TVzKUQjdClmg6saIJFtI7jM2/441MzbmG8eGe2HDxMypxAK4Xoi24Q0pU
         QsYCH/COjT4ajuXpvfsTkX5UbQs2SjPknVA1pN+xr0WOgpPI/e2AHbopIr2u1+X3Rm
         qDr+RC/6THiBEJLPqhmUwe6wBJhJLre5Ih70R6LNFuyEgNM9b7Vd/Zbk39SFfHp+mx
         /pJGHINlPLfmhO3t2kWYycli0CPhhxiKCYCnWEveVBlKQNt+g+Pb24vZw0Nr9DaKfr
         dbw74PbFxbhACF5il/LPw0aI6cXV6IZh72n/N8jYYVNU4ieG/0o3whnCYnn8GMPG69
         dvi4jUR5i/bXA==
Received: by mail-vs1-f48.google.com with SMTP id p1so6942084vsr.5;
        Fri, 20 Jan 2023 12:30:12 -0800 (PST)
X-Gm-Message-State: AFqh2kpN9RYuTBwfG1vsqPDRE8Okf8AHo1zJNSUEZrmwnuynVDHKZpd3
        nHBL3PTkzdw+Gwucqka8HC6Idfem2sSE+Y+KKw==
X-Google-Smtp-Source: AMrXdXsG6irlFQsfgggKr1c5h4xbn7pWIMYAOvP3OeFbZO0RKqovFlw4I28u65DZ1RDkN1g2cazylQt2MeV9uLFwxOA=
X-Received: by 2002:a05:6102:5490:b0:3b5:1fe4:f1c2 with SMTP id
 bk16-20020a056102549000b003b51fe4f1c2mr2235848vsb.0.1674246611773; Fri, 20
 Jan 2023 12:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20230118193056.673514-1-robh@kernel.org> <20230118193056.673514-2-robh@kernel.org>
 <4eca2695-cb73-eaad-4c8a-82dec923825e@gmail.com>
In-Reply-To: <4eca2695-cb73-eaad-4c8a-82dec923825e@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 20 Jan 2023 14:30:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKqiRbBJErkh2Hch+XZyLggGyjYo1rvKWPhxb99pA8mAA@mail.gmail.com>
Message-ID: <CAL_JsqKqiRbBJErkh2Hch+XZyLggGyjYo1rvKWPhxb99pA8mAA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: usb: rockchip,dwc3: Move RK3399 to
 its own schema
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 3:05 PM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Hi,
>
> Some alignment at the examples and the unknown extcon property.
>
> usb@fe800000: 'extcon' does not match any of the regexes

Does that go in the wrapper or dwc3 node?:

arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: usb@fe800000:
usb@fe800000: Unevaluated properties are not allowed ('extcon' was
unexpected)
        From schema:
/home/rob/proj/linux-dt/Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml

That's the dwc3 node, but the majority are in the wrapper node, so I'm
going with the majority and leaving this one.

Rob
