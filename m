Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF05C73A633
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjFVQiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjFVQhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:37:48 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23D71FCC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:37:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9887ebe16d0so675016966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687451866; x=1690043866;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CLyEL7yfBjwum4+9Fol9NPuQIxuEzbURTZLWy+RJtAs=;
        b=olRyJ8IakYqGk3VonAa5vzyrfVVWQyAb/LRwM/7SnBjlA89nzfxQlyqNMj4fLa1WS8
         0TuErhhRMypQ4LW51fXxz3Vkum2vrVanV5zBoy+rkDmqdQZhoTqAVba7h0WWTgqELEF2
         g+9jjfK93FB0iNOPn2kPa/32cVa/IsayjRbVfDyH8U4jJUtJuFcsY7ZCaEPTKSyRwU1v
         UhApEBN9m0vVEPcgUMSAM7jpMQzJ6+hqy3FUpaWeIbGtpv1s3rPfV7H2buWQGWZ3mdHS
         19Ps7Y+KFG6GepkcG5kKTR2mQSOdQGG7FXibSXlM5nMlzayjA/zPcKrIyCJU+m4uZ193
         J6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687451866; x=1690043866;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLyEL7yfBjwum4+9Fol9NPuQIxuEzbURTZLWy+RJtAs=;
        b=GSwVxRPjxhBtJXjPMhYEkXpjhjohm2vntkN38ZK6szzZ4pd23bka2+K1+bynl6G302
         v2CctT37s20Vi9pX2y1Px7cMx0h4jKqMSyQMFxJ75WZCWaVg0zWzbwcu2qtuodhorbGz
         AY2Io8GMY4sNng/LPg6dys+Vwj9yuRfVSafi4hOoo4G0p/oAcuTMc4RQl9k7X0MSdp2A
         KX1yAtcupaKpbI6HvjSOYyu3UiqvOoIN5fJ9sIVHeFXXFo59pEpSNrG5SoWGwUWn4YxI
         woQ3sQIDxHTzkWl/TgkGmhmSRGZacEeveXrLvipBPtTAl6R0W7kw5i9++fxHSSDROO0Z
         Ix4Q==
X-Gm-Message-State: AC+VfDx7EAcN1k/o96fk/U9P5ekUHK1JMp0L618TvPOHJzoYacpKS5Sr
        LiQ+5aHdTYui86Uwz3fp/eSuP84CrRreRpQk7vQ=
X-Google-Smtp-Source: ACHHUZ4meIn2VI8BBkAYG7exnQ0o5erH6W/+mCIPcmLcy5jYMg6Du3qfa7Q6psdKh5mvuLKmkztas83sN9F6g6wdB/E=
X-Received: by 2002:a17:906:7943:b0:987:e23f:6d7a with SMTP id
 l3-20020a170906794300b00987e23f6d7amr13321059ejo.25.1687451866001; Thu, 22
 Jun 2023 09:37:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:1b17:b0:973:96cf:a6b9 with HTTP; Thu, 22 Jun 2023
 09:37:45 -0700 (PDT)
Reply-To: aflimited@secretary.net
From:   AFLTD <burymic@gmail.com>
Date:   Thu, 22 Jun 2023 09:37:45 -0700
Message-ID: <CAEHYQyb4hubr5AXfqorcT6beDg0fC1NW-FHYm=ARSffVf-EEMA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:632 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [burymic[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.5 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wir sind ein erstklassiges Finanzinstitut, das interessierten
Privatpersonen oder Unternehmen flexible Kredite in der Gr=C3=B6=C3=9Fenord=
nung
von 10.000 bis 10 Millionen Euro zu einem Zinssatz von 2 % anbietet.
Kontaktieren Sie diese E-Mail:aflimited@secretary.net
