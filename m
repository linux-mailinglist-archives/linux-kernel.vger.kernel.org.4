Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D350F73CD95
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 02:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjFYAxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 20:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFYAxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 20:53:11 -0400
X-Greylist: delayed 138 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 24 Jun 2023 17:53:09 PDT
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BFB10D8;
        Sat, 24 Jun 2023 17:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1687654387;
        bh=gQH4VaAwMjpN/17+66P6tp7c9VnLsslmB8qz1LllLJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=zYlfl6mEXm2bGrHLswgty64ZXiywBYn0psiAYhkPVD3iKbtiYJ0mEtCS7xAjjvSFE
         i4G/H+so735Ap19ytImuFErGlSMVCGYXznV9nz4SihkJ4zVMWooai4QcUhulBiVS6m
         6N6qcjUzYLmjYve0l93qbEgDpoUZRpunfw2csV5M=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id D441B6B7; Sun, 25 Jun 2023 08:53:04 +0800
X-QQ-mid: xmsmtpt1687654384tphqfewpw
Message-ID: <tencent_DE0C5A84DAB2B62E1B543C5F4B4727118F09@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTPAq7WF7g3gVA8xXBb7bkZIy6xeiCUzUlrR3syishj+Ur2X7kxZ
         rdECZFBxwRu3ZMZgI+gN3I0jCGDY9rhfqcH+aNfsULkSB57pAsnpkNC2VVfOwNqxEtwQwyoqn1lX
         HCdP9MOLb3SLeFezh97/bibNxfNw86EUXUAJYBBR3TS8GUjQeuZwc+3n62ZMD6x6q/p8b/7wFzWe
         BghXoSde/DmyXvQSoyGTXTxdKq6+cSVTvU2jxTRTQ+uyKl3bCjjYFv2CZJFsz/pWNDBlh3OKPmkj
         8vc0rZ+tRWikjCzuL5koghXfPU0vFo0QdPR72CmfLpbP0E8jI6UBDFLayS+f0VGq/3NSC3xF6IIs
         1mdNDvj/N/PqlaP01ExYkL/+RsL1ZtZuvgwr8c2Jh1F8WFQpKa5lEDzkrOUu8xmfyPmNDAXiyXoN
         llkIZQrIDABF0zfv/BEOg31qyqYELkmRpvE/3xiqU1mlYnUaJ9XDt8K6es2c0PlObrqfwgNmgQ5u
         45N6vJpMclLLg/bU6ggarvEKAhv8I+FvsSbQgmYe4N3ke8tMLecF7jDjPeP2nhFgatFhV8/thOdz
         fPvh1DlBJUuF+nAVMl30u7OYN0HOYzdquZuNBn04cyETPiNrS4G+LmvenPOm5/ShmE6ssmWf3g6r
         xHxof6qzW2yThrFZtsd5/Bmes2FRMf4vXbgjbeOx+HP7HyjVkHxQiHMp6jM4I5+J+z9nKRv7PFej
         o1hL4Da02/BZMZvoXHj1yVHFR7lHpO9Yqz7KG1HOUp2pn3pSziWK8LqEXYh7ZzRGZEbCtckCXN9T
         xWBUJkvU5j+MuQ+puIEFPFjBNUNgEkr7u6XZD9bvocIkE+oONZECeqSWfO3FII1bJDhQnTXwxfYH
         GjZlcB2g+R02V0LvoKHGOU9Ier/L3j1aB2SPi4+rCOR4Fe6i6EsQ3eWURSiMJVfkqYUfL5FXQ/J1
         OJADEcZXH8Af0p2vzGOJIF7Q0hBHktGLzDCXG34hBm5YC26LeE4DeG3SS8N6l4
X-QQ-XMRINFO: MMd9k4KOWfk4EI9u9DiMAPPHFKKkl9Wo5w==
From:   Rong Tao <rtoax@foxmail.com>
To:     bvanassche@acm.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, michael.christie@oracle.com,
        rongtao@cestc.cn, rtoax@foxmail.com, target-devel@vger.kernel.org
Subject: Re: Re: [PATCH] docs: target: Convert tcm_mod_builder.py print syntax to python3
Date:   Sun, 25 Jun 2023 08:53:03 +0800
X-OQ-MSGID: <20230625005303.5464-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <debdc47a-c377-e457-5643-415d93ced54a@acm.org>
References: <debdc47a-c377-e457-5643-415d93ced54a@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply, I just submit v2[0], remove tcm_mod_builder.py
totally. Please review.

Thanks,

Rong Tao.


[0] https://lore.kernel.org/lkml/tencent_E3643D5F0AA8CCBEF28C6A233A18B808CD0A@qq.com/

