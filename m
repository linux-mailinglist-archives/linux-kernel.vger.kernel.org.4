Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFED63A253
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiK1Hyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiK1Hyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:54:44 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1451CC37;
        Sun, 27 Nov 2022 23:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1669622065; bh=l+U0T/Rd2eXdAseoL2kbnPGmga6pXph0NSJHHSCRLDo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SHYo88/n9BZIoXqljs9nOqiwIyPxaY/XM6FfuViUP6uqe9NtVCh4t8+StTOJ3n6ka
         dqLXaXLMkvTNegGoTzoQpt5+ZnK4kV5/b/ihdGbRp5vR/kpmNdQCxgk430Z34AxhKv
         9zWWnU53rFvdYzhELXX1ZaXw1MuTAohRDf3CLFmmiqTdlqrejQWuB3umGDjQZjI6kl
         Ap+jtI3sQt3N/6FWxjpUvXIOhsVupNm64J8e32+TA9NIvTch8oN4wAoR8GikmIMsuB
         7un8Y5A3mRw1MvHGNQrkcMFiCJjpb8w41oPLzgFmYxMNZ/kMr3kmRU4dUGItE3wsGj
         D9iajZ/plB8/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [91.65.146.82] ([91.65.146.82]) by web-mail.gmx.net
 (3c-app-gmx-bs10.server.lan [172.19.170.61]) (via HTTP); Mon, 28 Nov 2022
 08:54:25 +0100
MIME-Version: 1.0
Message-ID: <trinity-50896a7d-eff4-424e-98d7-ab33ac2587db-1669622065632@3c-app-gmx-bs10>
From:   Robert Schlabbach <robert_s@gmx.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH -next] media: dvb/frontend.h: fix kernel-doc warnings
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 28 Nov 2022 08:54:25 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20221128054303.3124-1-rdunlap@infradead.org>
References: <20221128054303.3124-1-rdunlap@infradead.org>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:L3Z6jtlzUGImJGN99vpeUabCOjuQukxXS1/jGMDWbfPGn6Go5qCqTZSUMh2xXednlD2BT
 r8oR0nSuBiBrw+r386GeLaDCk27c27to+7LNiL38F9JuErNk8v9JZjcQLGEUX/fNGcc8IDWXKDp0
 m5qVStMCC28VWQnKhDGZXIVAmoQ/9BW8GKJoIDAOtFkILMuVJlKhrd6zP4jHobbUFiBTiNCsHC6C
 Gr9a6+NzD9Q5CUnpG4NNJnzTUOpMGOrpDdJf5+rr+JM/MZRlckPLbh0N+Zg9kqFKVmshVQ3S9xec
 vs=
UI-OutboundReport: notjunk:1;M01:P0:pf6JK/LzQAU=;E5iXPqUe6USmVcUjIfwQv/8xRvt
 +P/qZrA7yWhl+4FD41OpdVZA7yf0VE4SQY8P9sqJhMMIR7og4zhxV3BPqhaj0EtA2Pq/LoX9f
 PTeyBBJjL5NCoZxqA9kdRL/Ry4ybawJIe8jJORTennLKIUtzYw7ROIHhFdHwYMMvuLA7OaqfQ
 kR9KhtGI8QZiRIK2LuMziqqi736KBm0JCqKtdzeBjFQz18dtVXIzJkUtJQ4ZucYtohUKbgSWg
 G35udbcZMQx+7T6qiqIR7NrP0aEjrNGiGADdc8i4cYgEo7TLzlpPonPuuad10fbagaz4YsEAx
 HUrgOf2v5KJ3TG+N5vpSWuX2u97GVBksWQpYwUcTTDpAE0H+bB+tGX9bihMY1bOpWjWAKJVQL
 fyFgXjUB1sDmm2yCtF0kcyRNHwaYvrM+F2rwTQaNYGFhCeAS+8QGTsF5ukXturWRQvIFnOq/d
 Rd/pYs3He8MpxMECkR5dbeYFVBg7acH++dwnNnN9MpgBFgkwA8C2X/t9IXWr41rgMkOdE1yl/
 0HlFq7CWv6P1kOByvivS9cP2DqDW0XgfEooUlhWOVOKa/IlWSqPzTVxJUkA8NijGmziLIv+WM
 0sA/H3bxlrGj6lSG5pU0Y8Umgw/YfDqQOJrFveoRcHF80eBeaQBXPre7uuOtF5CU1h0tSY0bh
 7g0L6KmpBkqGQD4MYDNzoNwJ6W/YEpdlMZSQVLXYXcmPherMAKnJdsGWt1vb5J+ojvPZiikLu
 OtXnuctPy9Lfn9AnAFCQqW/zuG+D2p2gpv3T5nYyIdi26b9ANdLvi5xWrz+KIWyDoAmE7RpHp
 RtkvEOB8EkkyDw8dJA5Ppzh9dmy6fCgTjcI9ASY3WxwM4=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From:=C2=A0"Randy Dunlap" <rdunlap@infradead=2Eorg>
> Subject:=C2=A0[PATCH -next] media: dvb/frontend=2Eh: fix kernel-doc warn=
ings
>=20
> scripts/kernel-doc spouts multiple warnings, so fix them:

Wow, sorry for introducing those, and thanks for promptly providing a fix!

Reviewed-by: Robert Schlabbach <robert_s@gmx=2Enet>

Best Regards,
--=20
Robert Schlabbach
