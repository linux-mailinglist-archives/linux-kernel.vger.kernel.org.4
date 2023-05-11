Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3AA6FE9AB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 03:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjEKB5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 21:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEKB5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 21:57:20 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67B1E5B89;
        Wed, 10 May 2023 18:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Content-Type:From:Mime-Version:Subject:Message-Id:
        Date; bh=TCXfahH34hYJqqM1SC8s3Anj/uF5zt4/S2+/aK5TN+I=; b=lYFYwiP
        rORVUhXZD/CUiM4kmhoO3M+EWN1NOs6+lYJ6oOfi1P2OPnoYs1MTEDRgFg/LyS5G
        zQniEN2HYeVQF6wbFXKkeUPadp/QGfUEKY5rSd7Sxx8MVbCrJIRDKSMgo4jy4l4f
        EQ9LA/kBePjJTIN4jaV6NAzpzByBfreTBDXo=
Received: from smtpclient.apple (unknown [223.148.153.92])
        by zwqz-smtp-mta-g3-4 (Coremail) with SMTP id _____wB3n4ddS1xkRp4sBg--.9829S2;
        Thu, 11 May 2023 09:56:46 +0800 (CST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Hao Ge <gehao618@163.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mediatek/clk-mt8173-apmixedsys: use devm_of_iomap to avoid resource leak in clk_mt8173_apmixed_probe
Message-Id: <7F568F0F-1F19-4302-8BBB-556146B3C521@163.com>
Date:   Thu, 11 May 2023 09:56:35 +0800
Cc:     Hao Ge <gehao@kylinos.cn>, angelogioacchino.delregno@collabora.com,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        wenst@chromium.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
To:     Stephen Boyd <sboyd@kernel.org>
X-Mailer: iPhone Mail (20E252)
X-CM-TRANSID: _____wB3n4ddS1xkRp4sBg--.9829S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrZw4rGw1xCr45Ar1fKr1UGFg_yoW8Jr1kpF
        ykKFWqkFWkJFy2ka1vva18tay5Aws8ZrZ3Z3Wagr9Ivan8Zry5u34rKFs5XF48trW3Gr4Y
        qrZ8K3s7KFW7ZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jI5lbUUUUU=
X-Originating-IP: [223.148.153.92]
X-CM-SenderInfo: 5jhkt0qwryqiywtou0bp/1tbiNB9sFlaECrAlcAAAss
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=EF=BB=BF

> On May 11, 2023, at 09:27, Hao Ge <gehao618@163.com> wrote:
>=20
> =EF=BB=BFOn Wed, 10 May 2023 14:18:08 -0700
> Stephen Boyd <sboyd@kernel.org> wrote:
>=20
>> Quoting Hao Ge (2023-05-08 19:12:14)
>>> Use devm_platform_ioremap_resource to take the place of of_iomap for
>>> avoid that we don't called iounmap when return some error or remove
>>> device.
>>> Fixes: 4c02c9af3cb9 ("clk: mediatek: mt8173: Break down clock
>>> drivers and allow module build") Signed-off-by: Hao Ge
>>> <gehao@kylinos.cn> --- =20
>> Is this v3?
> Hi Stephen
>=20
> yes,Perhaps you are too busy,I have not received a response
> in the future, so you are unsure about the status of V2.
> So I adjusted the code and title make changes smaller and
> sent V3 for it.It is precisely because of these that I did=20
> not continue the original mail thread.
>=20
> Best regards
> Hao
Hi Stephen

I made a few typos in my previous email. To avoid misunderstandings, I corre=
cted them and sent a new one.

Yes,Perhaps you are too busy,I have not received a response in the future, s=
o I am unsure about the status of V2.So I adjusted the code and title make c=
hanges smaller and
sent V3 for it.It is precisely because of these that I did not continue the o=
riginal mail thread.

Best regards
Hao=

