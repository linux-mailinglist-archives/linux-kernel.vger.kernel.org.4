Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56BF5F85C8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 17:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJHPPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 11:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJHPPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 11:15:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A636832046;
        Sat,  8 Oct 2022 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665242101;
        bh=pT+YvmFx86ZSRazUbQ1khlHAbFup4jFsua+nZ8coxrQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=UrhWtuMt+NOPatqC2vk5zYLOGlFAGvGulPCWC3+yC3rzdFSjYiQ7gX8aJ0Jzd++x9
         0zrGoooR6NaQ4hNEbUILdxytE7uN1MkvuetC05mvf7bKt5VmbQGvOtX78Rm/25Yy3Q
         aCmD3rx6Xy9R/ojOPL14sY+r4fnXiDcuVmWkSCew=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from probook ([78.35.76.13]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZTmO-1oeWTz32la-00WWv9; Sat, 08
 Oct 2022 17:15:01 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-mem: Fix typo (of -> or)
Date:   Sat,  8 Oct 2022 17:14:59 +0200
Message-Id: <20221008151459.1421406-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3X7soPc5ep5h8tcmlIxudQ3P+PHqn5AR9HKGPFe6swFMv99XAWe
 TdNhHN0HxKJFfG4MvSuRoes5vDx47Aog1DeoKitZab/IVxPpt8sStlgkfRKoNVOwq7xcEUA
 uOW3l96HmyIKACRiw2hJMx7iAhwdgAzaTDcUofZ9gCznraXZtrHjUCRFL0y8xyGh6qLtQzQ
 OaHXewSlPsfLpEwNW24QA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:in96Q6H9iZg=:WFmEWPlapNPaX6/nPPh59S
 uh7bH0rMuPU+MH+Ue7miLk0R+rr0MDaL/EJW8g3LGjBkcKk1wphikf3cZs7nBjcAgUaRlw48N
 54aM3PbIxOU1H9L/FdTLA75WFSmPewZir038hhJFl3aYUSUTr7IfoVd7dZ55thtRfV6/M/xz5
 V40cn7aAIWMaXV+dDPIB8h1ts3Oe2r1CM8wKa0FnvbIfqTzr9DO1GSxWVHeQRaEdDNv97sklS
 NHtditeDT5OFcYBw7fIqVfcGCcVW+r13PB0pzWxl/8wpOKWb7FVoCEluvQ5QrAbg2RIZI8oVb
 700mprWLiDlmSxxzcE97RD+XZrq8/aGysQ+JrstU8IC+Tfz8No8BF09B8PtIgiyJIdGz/bASi
 HNDwl56w5TC+C33s51t3PKVVIL9Og1s30LFZL/VqcL4DHS5iWENJFwGou5ohowtDa36A0Psjx
 +3WiCse9bTHJclhigEEF+UdmkNAaW4CVA9hyhmsRWbMI+zdE7pZQQbtXYM3sV1mRk+njeBrRl
 jm4FYq4zSIROOjABoHavAkwysmx9v68jWeqjk8tSbNfvZ79y5Q+HMAPH99JoXMQMZ2mYnHv95
 G9+HVfrhVqfcScsEMNgHoO+lJCpS+kqbD0QggxAa9L7NYYDXMD9LFhFWXvJu9+tCsaUrsyoi6
 OD27eRCe2W+lSRV7yZWY71+4+Wm4fESEeVyxtg3auHkv+aeo7GO82ebrOvEQXXbmaFz1nxgky
 DYg4LHPdC5uXk7b5Hda8u7I0u/bnPYEgubbG6SIZr4MPEaq0OZ5tEB09LLYZf5USUIICoufq3
 knJ7z0hznxbt9ULbAYKhCDrAuqL0++0TFYgzcTMjCooYq90W8v8DkKXH9KkiWJEqyk6wvT54R
 wbvutA4FKU3oSgqeYRzWE5BZrJGsaJBv66a+7pWEfhZWNpOAhxzG9ZzHj4D2tKLG6h/4P9fru
 los5OaHrTIuqjU7IY83qt/sIJ+OF1KRANv9bkTxqnyBHTlJqNT1YC1H12jcKxagSla0uCJXUC
 r0TVPVtHpAD3BAYaXrUzIYcVF874LoL6pgm/oJBFzeYVnTU/vJDGbHz/KJTGTPhqQ3tnbNcXE
 qOIRRY1R+ZYbYPXy4L5+XlKFy1IZ/v6GCqFBUa5p/PXDb4f2/6xFcQFJyL7t9b9cgmic/f1Dg
 M5crk8m0VeauLWJStN6U4nthJ1ivWiSc3eJqFgKU9FY8Q8z3aTaRxH5R1ZSs/2RoM9Mw8djDA
 zsqLPjAF3MOD1meJ4T7VU7+mh0KAoPu+CrbxsS2HpcKfL6VT3o4TNmCnOMNRilaTsybg4E+2j
 YuxNF7s9rLjV19Y80YNeaFWFiuM8Z2yx07yKUJCAZWmE9utLUsROUopmRuF+/l9Efel/W7Dxz
 KBGNjk812EXYngRdw7Ncinl1P9Shd/TMUBsI1KJA2H1Ij8viDP/5eM1f9XZNEcLpvaUe4RL9+
 d8IgYgvtbaqMccJ+ocMvDPQXaMoR9GjQIiQsF3XhzAbGaqdd+NK6NL6eQSqDsUOMvOCIFnCpZ
 mz/d+hxqtlg0I92brkZg5yuo0JqEPxddN5Fk7EA2FL5bh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this instance, "or" makes more sense than "of", so I guess that "or"
was intended and "of" was a typo.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 include/linux/spi/spi-mem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 2ba044d0d5e5b..8e984d75f5b6c 100644
=2D-- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -225,7 +225,7 @@ static inline void *spi_mem_get_drvdata(struct spi_mem=
 *mem)
 /**
  * struct spi_controller_mem_ops - SPI memory operations
  * @adjust_op_size: shrink the data xfer of an operation to match control=
ler's
- *		    limitations (can be alignment of max RX/TX size
+ *		    limitations (can be alignment or max RX/TX size
  *		    limitations)
  * @supports_op: check if an operation is supported by the controller
  * @exec_op: execute a SPI memory operation
=2D-
2.35.1

