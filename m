Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF875EB635
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 02:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiI0AWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 20:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiI0AWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 20:22:31 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4981A50C9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:22:29 -0700 (PDT)
Date:   Tue, 27 Sep 2022 00:22:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1664238143; x=1664497343;
        bh=5j/BEoc0a/g5EW5k+sV4JTG+NFX2wc5KQ3lCLfh0eMc=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=oa2MVjC4hXURwkbhbHor4a9M7Eh0k3LlOha/g4vbR50HBLbRePoTZCBbrp8MuaKrk
         sV1KI0he81EW1Hq0okXORCfVZpsPstL6bezNG2f8jmPYJaEzKgq+6IUlTv7BnGbDCy
         BC8VOBdFXbsQB7zg2Dftw7VC2iTggAZZa2bPcDyms5/WVxUIwMGyBife2ZRyRyKwp7
         9llUKL+rA6XQ3uuObyyDEu3NzHu0t26xMzEMBkxlLx8CEv+ih9H8XnSrN3QpWuRvt9
         ShHp//DGu7x4TS0iJzZyc4q1N/Ygn9MC0mX4+Z1d6j4rnmxmWaSyVJlD0Ifop7G7mm
         dj6PYbM5JSPxQ==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Paul Starzetz <ihaquer@protonmail.com>
Subject: Linux Kernel 0day Exploit inside
Message-ID: <h9bY6oJIw5zGVb-cAXdz0dPk_Ti5vKRu5aLwoLharC7XaPh-kqjr-bIRVjNam1SaFsXhXu-BgN1ES-6tpbpMHygWkRqHRF4k7_nvQXOT9ak=@protonmail.com>
Feedback-ID: 52680148:user:proton
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_QhVbvzYDKvegn67m5RFd3bZMvgYrJbe08wKtOxE2Kk"
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--b1_QhVbvzYDKvegn67m5RFd3bZMvgYrJbe08wKtOxE2Kk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi folks,

after 13 years of professional experience I'm back on the market - company =
abandoned OS security research.

Zero day exploits for Linux kernel, Solaris, (Free)BSD, OsX (and more) can =
be produced upon request. Do not hesitate to contact me for CV.

sincerely,
P.Starzetz


Sent with Proton Mail secure email.
--b1_QhVbvzYDKvegn67m5RFd3bZMvgYrJbe08wKtOxE2Kk
Content-Type: text/x-csrc; name=i.c
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=i.c

I2luY2x1ZGUgPHN0ZGlvLmg+CgovKgogKiBjb21waWxlIHdpdGggZ2NjIGkuYyAtbyBpIC1PMQog
KiB0aGVuIHJ1biAuL2kKICogCiAqLwoKCmNoYXIgY29udGFjdFtdID0JIlxuIgoJCQkiQ29udGFj
dCBtZSBhdDoJXG4iCgkJCSJcbiIKCQkJImloYXF1ZXJAcHJvdG9ubWFpbC5jb21cbiIKCQkJIlxu
IgoJCQkiLS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tXG4iCgkJCSJcbiIKCQkJ
Im1RR05CR0xqTmc0QkRBREEyNDY0VThYT3JyRThVQ09selkxK0JUUzF4SzFBd2VUcTBZL2ZrQUJj
RjdQM09RcFJcbiIKCQkJImx0UzZNTG5yZDVXTVRTMytRMklKS1hlQ1JYcFVlTFRkeW5rdHg4bnJm
UmIvZkw4bjdxNUlueFJ4YVo2UVN1bDRcbiIKCQkJImYvYVNNbDlTeVpaWXpGb1RjV2lDWFFmR0Ev
cnRGU1RJaVVTQ21JNU9CR2xPSEtoYjF0UEtScXZLK3dlQUpZZDlcbiIKCQkJIm4rQVJFRkI1bXV3
aDVEeTJET2V4NkRSVk4wamNmb21Hd1kvdmJzdG1Jd1MrUjB2OUg5OE5TNmpaUkJkRkFrVUdcbiIK
CQkJIjd3MHR5UEpFdmI1MUtuK3Z3MGIycWgrYVR6bzl4eCt3ekxMK21JME5mekxxYnJldWs5ZWJL
SVpCNHdqb1VxNXVcbiIKCQkJIjRNZXNsaDZGdGRTbVhiMG52S3IzOVJubG8vcWRFSWR2eEFYTEY1
bzkzN3c5NWZwMDltQ0locmI1MWt2QmRiOFhcbiIKCQkJIm9xcDJQaXdhVEdQU3VhNVhBR3hoaXZS
Yk4vQXhtTWQyWk1JZjF6eUFWNVFjVzJQWHVxSVFyVjBYdU9HWEtaVkdcbiIKCQkJInhaRmZ0QkRi
NXhPT1U5bU1uOWZ5L0lVeHI2WDNFYnM2UVdPYjBNUVFaZEVnOExiM1BUbnowYzYxR0JLSmZXY3Rc
biIKCQkJIjNjcTlFZkg1WERTN3Z2OEFFUUVBQWJRbVVHRjFiQ0JUZEdGeWVtVjBlaUE4YVdoaGNY
Vmxja0J3Y205MGIyNXRcbiIKCQkJIllXbHNMbU52YlQ2SkFkUUVFd0VJQUQ0V0lRVFpSa29NR1hh
UnptVUI1RWpOOW9TSW85Q1QxQVVDWXVNMkRnSWJcbiIKCQkJIkF3VUpBOEpuQUFVTENRZ0hBZ1lW
Q2drSUN3SUVGZ0lEQVFJZUFRSVhnQUFLQ1JETjlvU0lvOUNUMUgwc0MvNDVcbiIKCQkJIm5MQ2hK
eUpxZndiWjJqdjRlUlFnVW9INjhLbUVPSHQydHZXSEhFdzFqSml3ZDYrcVVwbmNYOERTZ3ZhZWJP
NUJcbiIKCQkJIndJVWlxWnljU3JYSlZWamVJNDdoVDlPeXZGTncwcDhPUk9acWpUNUpuM21Yditw
U2pJcFg3ZXZ5TmQzbFR6a1dcbiIKCQkJIkxHbnE0Q1lINklSUnl1V3o1N0hWZHJQditPUlZ0NE11
Sm56eldHZlhocmRNcTFLaUE0M25QUkI4akdxakQ3VmFcbiIKCQkJIktoRFhjUFFjVnQxTUFFRTlF
ck9EWDBETEx6TFhqYmpXcitWTUNGSXhSSU10SVZFakFvSjBQMXhUOUNWWVZtQklcbiIKCQkJImRq
eDNtbU5DcGxSQkRCWnFMRmw2TzdvNmY0ZVhsNEttWnArSGZ1dVhjZ2p2ckk4ei95ckduSHRLZEFY
QUFGU0dcbiIKCQkJIjJWeXRGQ2I2WkZMOFNwcDJTY3RpRzljeGtrSFUrNll3Yjc4T1BUTHlRdUxl
Sk0xalZUcWI5Slp2emhtU2sxbjRcbiIKCQkJIndiZ3NZdWowbklicTgvdFNMd1VyRGpFRml3RmdG
Uk82N1pkYlp4WGdNUHRoOWdGbHZ4YVVxcjF1RTcrR05xWThcbiIKCQkJInNCL3pqaEJ4OFpwbFJP
cng0TzVwUGxuVC81RG8zSEtTT2QrVTl4ZVRWSWEwckVLQWhIK0ZFYW5kVHE3OXlsZTVcbiIKCQkJ
IkFZMEVZdU0yRGdFTUFNQXdJVDRMTEsvN21PQUNSTkJpSElvb1FndmtjTkF4bmlnS2pnV004SDRH
M242eFpDc21cbiIKCQkJInNlQjhxeExIV2tJdUNFOTQyNnc5dzAxS3lzNHhWd2puYlI5cVlDRmxC
MDVueUcweTNTU3hjcjdCYXJIYXRnR2pcbiIKCQkJImE3VDBqQ2tmdFhYQktyQWdzSnN0aWJ3TFhD
VDk5WGxhM1VIRmQxbkRNR1Axdjd5U1dNZldidEJJakh4cjI0K0xcbiIKCQkJIjY4c1Jhd1dDRHE0
Y3kvZVRsdkMvUWg0eGRyZlliWi9tN1hneGt5bWdEYXpOd0NHSnBMa0hEZ2FnS2Z4cVVIQjdcbiIK
CQkJIktVcGRicTVieW1QM2xNdzFETUJ0K29PTnJERlg0U0wzdElyNjJUamdPemQvcnBFeUk1ckhj
bTdjKzNuRy9HZ2lcbiIKCQkJImhCZ2w5N0I5UmdWUndETTdTK01hdzIxRW1uT0xtbE1uZ3RMY0Uz
V0Q3TEozL2tRckdubWZnc0lxaGtqUFh5enZcbiIKCQkJIjE2bWxlbnRwMmV0dkc4RXFvQjZaR3Zv
WEsyNndwbE5FUzhraU1qRzUyaDQya2FtWW1UVzRKd21nczdCcU1pcmxcbiIKCQkJIlNDbk1KOGRM
U3h1WExuTWdCelNEeHdPVDcwbDdSS1VKZjFMLzR6Ni9lbEF2OFMxM1N6SjdZVzJFN1ZzdTJGOURc
biIKCQkJIkFZR2w4QVF5dEhYZE1RQVJBUUFCaVFHOEJCZ0JDQUFtRmlFRTJVWktEQmwya2M1bEFl
Ukl6ZmFFaUtQUWs5UUZcbiIKCQkJIkFtTGpOZzRDR3d3RkNRUENad0FBQ2drUXpmYUVpS1BRazlU
QlZ3d0Fxazl6ZHFBUHBuUGNibm9rZC9qVzJCaldcbiIKCQkJIldKbUJEcXZ5bldyQndaL3dMcEY4
YmN3VW5acTM4SW42OVU0eC9ZYTNYVXY4eWdkcjloRVIwZzJuSmRHWjRFVHNcbiIKCQkJIk1uZDlB
MFFTbGE3U2U5RStzd3kxNFhPTUdjbEp3UFRva05wV1BpQ3IzQ1RUakZVaWNLbzMzMlBJZ0N1UTBC
c2lcbiIKCQkJIjB4bGVSRG80U1BmZTA2WDJEQkh4cW5PYkh0dDVMVmhJZmVHbnFuVFZUWFg5bDZ2
OURpQU9OZWRSdHZuU1lzOGJcbiIKCQkJImFta0hHKzlLV0sxZG9WVHEyQ2UxUzFvYVFaRFRsaGF3
dmNJWDlKc0w5ZDFSbXlQdG1ldU54cVl1NytTTUlBTjlcbiIKCQkJIkZrcjR4WXRRSmwzU1dKT2dr
eUpxc2V1NDY2QjhRTnM0Vkt2UUVFSUR6V2JrOVBZZmlma1lpYThVRTQxNUpzVUhcbiIKCQkJImFz
U0FqSVJhQVZFQ0wxVy82MEFoYVByWlJwYm9VczEzK1lLS1RiY0p5b3hJWVJJelAwa1pGckRNNjFw
bTF1ZXdcbiIKCQkJIkJ0T1hFdjEzSVNvUUpjOThlcHZ5OUIzcmQxRTNPb0NZWEdvb0NGR2ljeVY1
aUx5aUJUMmZoSDhYUXp1aksxQ1dcbiIKCQkJIlFhMmdPRWZRUnpFNkp2RkpzOXFiSW1KSk0wM2dW
MmZuUExzNDRDa2pcbiIKCQkJIj1QYXJkXG4iCgkJCSItLS0tLUVORCBQR1AgUFVCTElDIEtFWSBC
TE9DSy0tLS0tXG4iCgkJCSJcbiIKCQkJOwoKaW50IG1haW4oKQp7CglwcmludGYoIiVzIiwgY29u
dGFjdCk7CglmZmx1c2goc3Rkb3V0KTsKCQoJcmV0dXJuIDMxMzM3Owp9Cg==

--b1_QhVbvzYDKvegn67m5RFd3bZMvgYrJbe08wKtOxE2Kk--

