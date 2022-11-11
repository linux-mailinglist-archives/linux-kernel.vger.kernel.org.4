Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333AD625AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbiKKMqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbiKKMqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:46:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61689663C2;
        Fri, 11 Nov 2022 04:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1668170741;
        bh=qneJJGHoqWYbu5rchBDl5skDJGGz8YlMGk6gDkI/2nk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=rPLQNBZZO4h+5oiwI2s2dkXi55MzW4QCr4sgHtnRVk42EVw9x7hUBAiMdi5rJThUI
         67qgkiUv6jmUSweUtVbp1yUCwc052RTK1/oeN/ZQ5OlX+zjEAGxx0tC5zhOwJtyyPA
         3KDMamhoECn6W3NLh/mkDCvJ9zdHbjDW3ugczX7OkCe91cEAdBtK7KNDvTRctjuDSr
         rsxxIBErErvAj3zyIX3YQJmy9sHb6ZHbyTPyxOcvzJ9rFYb7J6WT/X2cbhjtibU3iD
         iKuSP3YsrTY3bIcWK0yILxwuAJFS/15/+dqJZpssy2o2LUWlDNTacd2PMKMSHyWXol
         j+WlBOp5Yyz8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [157.180.224.127] ([157.180.224.127]) by web-mail.gmx.net
 (3c-app-gmx-bap63.server.lan [172.19.172.133]) (via HTTP); Fri, 11 Nov 2022
 13:45:41 +0100
MIME-Version: 1.0
Message-ID: <trinity-6bc6a2db-9bdf-460a-a9e5-e8d5aebdc579-1668170741328@3c-app-gmx-bap63>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Shih <sam.shih@mediatek.com>
Subject: Aw: Re: [RFC v3 05/11] arm64: dts: mt7986: add mmc related device
 nodes
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 13:45:41 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <9955078b-72cd-4260-0cc2-ba1b9e0a0bdd@gmail.com>
References: <20221106085034.12582-1-linux@fw-web.de>
 <20221106085034.12582-6-linux@fw-web.de>
 <9955078b-72cd-4260-0cc2-ba1b9e0a0bdd@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:uVg3wzNrILOD0hMUF9OrIK2sauhiLJ0L97UfHqLn79TwvVMrQmYlpmXGxlzHuBUCoJ/GX
 aUX1+963E5c6LznpCZDV6oSScaJbsffhX1md/uYVYdPbhfKcBwJlpxiAkWpjFMWFEbwqFsu4APpX
 tV1jjb5/5cV6nfHMMs1OfSU197XcBuuzY5DApduT3jySQVptpt2tE1HBScZayl6as/Gpn+XVJv1g
 2jLTHGn5I15xaruDaqGUlKIMpCxkemuOOsS7xROP+7ivAijnJvrRQy6VZPFbWrMkwQsS8nH+7ow0
 C4=
UI-OutboundReport: notjunk:1;M01:P0:rJZgTu1YGdk=;FvoX5LF81jBREy7bE8wHMa7TySI
 yEAocm5OvPnl23qhZLSxMkzctb8ibQbCs8JW+wpty/cqdRqolQGddqFjyDWii4sjgO7UMvlR5
 SfqgUY4VVUEWd+1ffCNcPL4HqUi4s/lY7UpoJIICjMwD1seEtFOwAvrXPb4g1EbCMAdc5i/VD
 TIY+zoRRPe+4/Sc3Yc3FGZ/XYmmJdoWwK5WW7OB1kl9FSd8EAf3x2OqXHBAZ76+7G3awqKLnJ
 Gnn9+EQQ0ezLMvR2sZTYX0WwY2k78OBes4qJaxIcyGVJEjG+/xpu00caKUR2JvKtLsMDnR4xp
 RkNp6LM4h3QKDg/zhyvLlkUQEAG2nNnGFU0Uwc7Q/JIiB8jDe/F/L9ZMCskhjNECSiXBUBzjT
 ny9pbBUlnPFfQb/f51NyvOBR3yBDQNd3LVsyoxyHqIG0gGzz9EU3nDiTllXetNFP3w8qQ5nX2
 Yq4qoZ3sfn0RY9k0nXtY7lm4takQ9/XT2SLaQ5f1+y2jqGIKXjfZ9VAKRbhrz5yNYJ3yRMm5d
 PrepJytUIOz6Iw3Lo8GHrTbEBl8lzDSjDdNBlyC7Kaq8js1+Es7Fl4E7Z2APr/ig1/qDN0tvX
 an1JUQesY6+sKriQqiqea1NJiNkeIWBg06QjDLl1JFFoJ11PcMKzxMyBZmKe0mA/TqG9BYJrP
 9pi1hDCmp+732fTV2lyjf6OylZj8TPWNwtN37R/12Z4SeCB2gI+m6AagcIe1zggWoW3WCJ9Xf
 pllKUnNDwaWItt9HriBFpskVrREQwKlw4ah6V+vfKYVDVoc1Y6vREFXY3S+HfO2y4sBTEv0Sf
 iFew6wTF8aUtRIPZGX2hbN1g==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Freitag, 11. November 2022 um 09:58 Uhr
> Von: "Matthias Brugger" <matthias.bgg@gmail.com>

> >   &pio {
> > +	mmc0_pins_default: mmc0-pins {
> > +		mux {
> > +			function =3D "emmc";
> > +			groups =3D "emmc_51";
>
> Waiting on
> https://patchwork.kernel.org/project/linux-mediatek/patch/20221106080114=
.7426-3-linux@fw-web.de/
>
> Please correct me if I'm wrong.

this (newer version with some pinctrl-fixes) is applied to linus pinctrl t=
ree

https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/c=
ommit/?h=3Dfor-next&id=3Dc115e7f51e685536ecb885854bdd4b3f225ff3e4

> Matthias

regards Frank
