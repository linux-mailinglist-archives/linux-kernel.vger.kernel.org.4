Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15C06F0BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 20:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244346AbjD0SUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 14:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjD0SUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 14:20:01 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D4830F6;
        Thu, 27 Apr 2023 11:20:00 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-74d2597fdb2so436766085a.2;
        Thu, 27 Apr 2023 11:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682619600; x=1685211600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q7ATKwYmuUSj/ogSpDjDq/5jbaMNI6uN2RRcY4VcdQU=;
        b=JOCYJplpxoGq4Gx3tOkSbP5MJ1e8JEdMLZWEEKKqARz9vZ0cCP/2A5zaqBJUM2PdH8
         3fn+Gpg6iSnVEEW1QU1ACL0/909mfOd7cCBOuorbhRACGMBtd2x0dRxKOQTN/dw4W7g5
         p21U+sl6BgEybZ9Iq7IOLi+SLh8Xdem88Q6P4X2X4NBaAERAStw+CqIVy3WbADo7Cs1j
         PtRP885AlS9Rg6HHvTq/901NA2afjlvnamn2/5XCeFCpT5UQ3ZVSopKfi1544pDKHY3P
         tTMaGkiJbWYvGFqmgFuCJ2xWUVHg5LCXbOwgWddbNErkyvrlCMuzbaTkJVIQtlkHJgqU
         1BgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682619600; x=1685211600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7ATKwYmuUSj/ogSpDjDq/5jbaMNI6uN2RRcY4VcdQU=;
        b=DzWipB9NfwLXUJtU7wVkXzHshpEsufrhGIQer1PJ7QOU9zhd1zcMZHIIQTwxoZmPTb
         CN01a1OG9neMweDUbWMgJMJJ0EbsXfIK5U8fo0pEhgjj/IIoX8v4PFXk0aWqglf8lrGt
         djIYoW1E9yUOZAtwfR+OkRSQq+a10NvJz2zmLpIifFX90cLhIChOQ6En//Gsto3TeQTk
         qQP844FlbcxySzmaCeVBIhXM0jX9CTKNr/5gAFPBOC8FqjNQjDQ8LQA6KBUFDvctVOgd
         3Rmy2Va7BDEbUNOvurGifrqce2uEoC9TfzoBPKz0BP/BUwyzsvaOw2qnFWVz7jIqEhsy
         nE9g==
X-Gm-Message-State: AC+VfDxxfNpiHD8znS1TrisxiAJv3roSmxvifH8KON/a1t/hCaNx0dgy
        uwZQESmcEVf8fODLTnk24cCQt8pHUec=
X-Google-Smtp-Source: ACHHUZ5nf1sWqiRPMpIvBmXBWFXwoqYBBHvnQ6gThP4Mm//W1aDjHOS6sPIa48NYNaXFjJ6oN4KA6Q==
X-Received: by 2002:a05:6214:c47:b0:5ef:564a:3296 with SMTP id r7-20020a0562140c4700b005ef564a3296mr3654265qvj.44.1682619599827;
        Thu, 27 Apr 2023 11:19:59 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s14-20020a0cdc0e000000b005e5b30eef24sm5788316qvk.56.2023.04.27.11.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 11:19:59 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Cooper <alcooperx@gmail.com>,
        XuDong Liu <m202071377@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Jiri Slaby <jirislaby@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Doug Berger <opendmb@gmail.com>
Subject: [PATCH 0/2] serial: 8250_bcm7271: Fix clock handling
Date:   Thu, 27 Apr 2023 11:19:14 -0700
Message-Id: <20230427181916.2983697-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XuDong Liu offered a patch to correct some clock issues detected
in the probe function and Christophe JAILLET pointed out that
there was a similar issue in remove.

Since no V2 has appeared, I am providing this pair of commits to
address both cases. This set chooses to use a managed clock to
avoid the need to explicitly call clk_put from the driver.

Doug Berger (2):
  serial: 8250_bcm7271: balance clk_enable calls
  serial: 8250_bcm7271: fix leak in `brcmuart_probe`

 drivers/tty/serial/8250/8250_bcm7271.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.34.1

