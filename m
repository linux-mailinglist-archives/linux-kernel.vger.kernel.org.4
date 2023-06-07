Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B07172694E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjFGS47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjFGS45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:56:57 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753751702
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:56:55 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-75ec93ada25so290419585a.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686164214; x=1688756214;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=utxJu1j2ANZS5JbI6XwpefDqF+QZE/xBYgCXi7epqPo=;
        b=e4GLBpTwHuNNyPUWX9LPBQd5RWj7KUhswBJiSAXfeTP/ybPK+CX/wMABs2PtmUcLUs
         VBAUYJrkkmuSr9+Oy3KvKysb6gJhCyT/5DNUiROMPOyQKNIW0qGzsFT9KgrsFZDSN73s
         a9l6ZozK205UpCDXeDLzJC/0Wkejq9LadJxwv4DEXZ9YA1zNkcpHZRN0g15lycfrLSH7
         9adg92N0dAASYNcKMmbOuxx+kPzKwXk0ogzcm2LrQd9a8SEDcq6WOPPsLmGchODTidkK
         HaPFf6Jxf3sJv8dDeGcn/MJMdj24pLp/vzji58USSEefcM9hh68B+lpp9OHwkIECNNte
         3lqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686164214; x=1688756214;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utxJu1j2ANZS5JbI6XwpefDqF+QZE/xBYgCXi7epqPo=;
        b=P7gldwOsTaDvvCukaUxv5VXXefa2BReZz9mY3+yNUjOqNKzIe/Qepyi1JbiTXObIz4
         JywV6SM7Qe33J1BrXcIf2ycRxPM/8PrtCrw+qbNmR5wx+sta+Y1cqZ6SQoXRiqe9S7K0
         PUQ/VbQpzOa4NJfMHSflo/sUcSzxreSPIZlzvfQG9sHPpalu5cu9PZdRBdwPNfd2TnGY
         7HRH+IuJc0dkJL4B10w2KphkkU8hmCTE+ImQGKU2TlgFPgC0V2zF+59tS9Jn2kc27t10
         rZ/LWbbfuiNoL2VYKOcVIR/E3pSe3HuV8nxG1Ed/4OAhzmZJlp5qTGJwhvlfmLyXK2gE
         sxNA==
X-Gm-Message-State: AC+VfDywOdQgIKLcr4tVWT51wbn1k4lcPpo3rlghhuUxeLnIV1wQ4MsV
        xHbP4tSJ++ae/F/Ct1j6ZzBHT+Z0lcQhhuTHGv0=
X-Google-Smtp-Source: ACHHUZ4vFA4PM8Z5uYoyxJWZQMq5gNAAxsQCLRdQpDvYgQx6FNAUdpsCNa0zsZl20tnWSszurfa0YtcKqvYBepYyvUI=
X-Received: by 2002:a05:620a:890a:b0:75e:d11d:51ab with SMTP id
 ql10-20020a05620a890a00b0075ed11d51abmr3452025qkn.9.1686164214497; Wed, 07
 Jun 2023 11:56:54 -0700 (PDT)
MIME-Version: 1.0
Reply-To: susanarodriguezvidarte@gmail.com
From:   =?UTF-8?Q?Susana_Rodr=C3=ADguez_Vidarte?= 
        <susanarodriguezvidarte@gmail.com>
Date:   Wed, 7 Jun 2023 18:56:38 +0000
Message-ID: <CAF1o4SymqMENAdvj2hgHPbpYLrBeMKtRVWZYWS8LHuTO_e3r6A@mail.gmail.com>
Subject: tr
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
puis-je vous faire confiance dans cette belle opportunit=C3=A9
