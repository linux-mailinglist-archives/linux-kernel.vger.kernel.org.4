Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790B46A1D01
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjBXNbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjBXNbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:31:38 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36C0584A8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:31:36 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id gi3-20020a17090b110300b0023762f642dcso2711057pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cCauAobpo9XpCC17lV+JICFK3jz06KDI3m2pTratXWY=;
        b=VjK5lzf4WQlrohPwPA2LtCpraNdWCyYsd3vQe/QK64Nqy+hbwIIFqRuz5DsNXwbx0l
         W6kXEPr0nA8RClhGIdX7QVEETX0Uk5DU6Fm/p9zeWBd0C27a/ZmaD7SBomqY9hMuLtfC
         aYj69zg6Z1TQZlRAtHXaiSY46goAsVvUOTxmCbFgYkElBVSRe9dD1Y9MA5/JYTi55qaO
         UWDQCXChjKSFDq1bwRU4OAHKQ/z9cFXb+1XbrBV+iKuLCQ4LeO5F/LsUNBpe6R+6Jcn1
         sMU6RK8xS8EVpsz29rhc5G8ktMEx/6oMAu6q/D/FtVBCLTLlsDSh6Ar77l9mymX4/csu
         qDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCauAobpo9XpCC17lV+JICFK3jz06KDI3m2pTratXWY=;
        b=ospLZC7vlid/2rM95smbCLC8J9mv3+2E+76wMHG0y0ogaEw5wcNBK9wgdGocKs/C8o
         /Uwm46CF8jRpO8NXrOhntbnYm7Us+6GXb9YJk4iQWB3r5NmrxlKDpuJIfnEGDyqSZN13
         7jyhmDBFn7RWZWKWraYh1X0tAj1P+5VawoFOgWD2IAiY9dxcfojw9n/ir8swznWle2Jx
         FhN4n5D8Y5f4z/WSAApJQEs6rkZ34src11aSlzU/Fj7vMjEFYnKwgNEapEqAyhY/4uue
         s5gIemyHWzWkMkWYnbxEnPOXZfuoOwPVdMInNq5RpViCJMY4rOW6Pg1tTDPY5swHHEOV
         8Iqg==
X-Gm-Message-State: AO0yUKVhLlF2UrI7NjI2lTNmMMNSE3S6qCHb6pfRZFxaL7XwTjOl5Jsa
        3gfV2wOm5yg8fN5qoOQEHnmZXHhfGUHq4BsuogE=
X-Google-Smtp-Source: AK7set/CL63m7G3G+qDAe5U7DMePEP26Ql6UwisiEZW4trdSVs1Cj2W8AXd5/TB0prxeAA8/cjUH+0iVTJCOuPGvxx0=
X-Received: by 2002:a17:903:2682:b0:199:56f2:3fc4 with SMTP id
 jf2-20020a170903268200b0019956f23fc4mr2946684plb.8.1677245495829; Fri, 24 Feb
 2023 05:31:35 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:902:868a:b0:19c:33ef:ed7e with HTTP; Fri, 24 Feb 2023
 05:31:35 -0800 (PST)
Reply-To: wu.wuheadofficemts.wu.tg@gmail.com
From:   WESTERN UNION <wu.wuheadofficertrs.wu.tg@gmail.com>
Date:   Fri, 24 Feb 2023 13:31:35 +0000
Message-ID: <CACBUExP0NFaGxx1oC46gTQn-E+fjCgPVu9z68vQ6oeNiTUmEzg@mail.gmail.com>
Subject: =?UTF-8?B?UG96b3I6IFbDocW+ZW7DvSBwxZnDrWplbWNp?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1042 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [wu.wuheadofficertrs.wu.tg[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UG96b3I6IFbDocW+ZW7DvSBwxZnDrWplbWNpLA0KDQpCdcSPdGUgaW5mb3Jtb3bDoW5pLCDFvmUg
anNtZSBvYmRyxb5lbGkgc2NodsOhbGVuw70gc291Ym9yIHBsYXRlYiBvZA0KRkVERVLDgUxOw41I
TyBNSU5JU1RFUlNUVkEgRklOQU5Dw40gdmUgc3BvamVuw60gcyBNZXppbsOhcm9kbsOtbSBtxJtu
b3bDvW0NCmZvbmRlbSAoTU1GKSBvZMWha29kbsSbbsOtIG9ixJt0w60gcG9kdm9kdSBhIHZhxaFl
IGUtbWFpbG92w6EgYWRyZXNhIGplIG1lemkNCnV2ZWRlbsO9bWkgb2LEm8WlbWkuDQoNClDDrcWh
aSB2w6FtLCBhYnljaCB2w6FzIGluZm9ybW92YWwsIMW+ZSB2w6FtIGJ1ZGVtZSB6YXPDrWxhdCAk
NS4wMDAuMDAgVVNEDQpkZW5uxJsgeiBuYcWhw60ga2FuY2Vsw6HFmWUgemRlLCBwcm90b8W+ZSBq
c21lIGRvc3RhbGkgbWFuZMOhdCBwxZlldsOpc3QgdmHFoWkNCnBsbm91IGtvbXBlbnphxI1uw60g
cGxhdGJ1IHZlIHbDvcWhaSAkODAwLjAwMC4wMCBVU0Qgb2QgTWV6aW7DoXJvZG7DrWhvDQptxJtu
b3bDqWhvIGZvbmR1IChNTUYpIGEgRkVERVLDgUxOw41ITyBNSU5JU1RFUlNUVkEgRklOQU5Dw40u
IFZhxaFlIG9zb2Juw60NCmlkZW50aWZpa2HEjW7DrSDEjcOtc2xvIHBvc2t5dG51dMOpIHTDvW1l
bSBJLk0uRiBqZSBDUFAwOTIwVEcuDQoNClpkZSBqc291IHBsYXRlYm7DrSDDumRhamUsIGt0ZXLD
qSBwb3XFvmlqZW1lIGsgcMWZZWTDoW7DrSB2YcWhw60gZGVubsOtIHBsYXRieS4NCg0KSm3DqW5v
IG9kZXPDrWxhdGVsZTogRWxhaW5lIEpvaG5zb24NCk90w6F6a2E6IFBsYXRiYQ0KT2Rwb3bEm8SP
OiBBbm8NCsSMw6FzdGthOiAkNS4wMDAuMDAgVVNEDQpNxJtzdG86IExvbWUNClplbcSbOiBUb2dv
DQoNClBPWk7DgU1LQTogTVRDTiB2w6FtIGJ1ZGUgemFzbMOhbm8gcG8gdmHFocOtIG9kcG92xJtk
aSBhIHBvdHZyemVuw60gaW5mb3JtYWPDrQ0KbyB2YcWhZW0gcMWZw61qZW1jaSwgYWJ5IHNlIHDF
mWVkZcWhbG8gY2h5Ym7DqW11IHDFmWVub3N1Lg0KDQrEjGVrw6FtZSBuYSB2YcWhaSBuYWzDqWhh
dm91IG9kcG92xJvEjywgYWJ5Y2hvbSBtb2hsaSBwb2tyYcSNb3ZhdCB2IHBsYXRixJsuDQoNClbD
ocWhIHbEm3Juw70sDQpWZWRvdWPDrSBwb2JvxI1reToNCg==
