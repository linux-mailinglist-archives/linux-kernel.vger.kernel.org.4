Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9826FF8BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbjEKRvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbjEKRvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:51:19 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6145119BA
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:51:14 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-55a5e0f5b1aso87662617b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683827473; x=1686419473;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AJf82yenaiO5gd3GrLwZqndqFsgk7YATjQEjq8QoNyo=;
        b=nFPOQHMQlzPNwdJ8+1XfMbmdj5/OgtPiaTOxfwWE2Yj4L8/p4fnSAsKHY1F1jiw3WH
         hiOqGVfqT7mkcHGMqchJOLLzoVe8Uq//4NfE2whgaB5/Pp3sVY9tVOhgnJXnUuhka214
         0jhFc4SBtar21kA6Bro2hYAA8KZczbp63vpgb94MSZGN+lSDi7zfgXr2obeenNO87BYZ
         w+BJjmboVBiGhcrjsLlAmj5TWznKhDFF+1IaIo/xIhhHOy+4ubjF6j+U/xzMEzJdLkeU
         xm5fXd4hPce9yiYYP9UJ+V0+Gf4KSzsxSHkUd75FiVvbpBiwJUxb/DL0mA9rQyHpnULv
         D+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683827473; x=1686419473;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJf82yenaiO5gd3GrLwZqndqFsgk7YATjQEjq8QoNyo=;
        b=aPsdUE01Pecqsgmj4E+zN6qbamqwEA6sp31Kt1KpFFaQRLGhCFimjUVpohscUVAlDt
         6ai6GVnBB+XFGEAp7//NAblACKo/TY6TKAtJjJA4ywg9VVH/3c3R0rZLgrD9vLpmv5oq
         ggzQcu37YuhtW6LRv9a6LGyAbs5wPXb17Pm207VAcdlpgYyCcRyJnAX3q1e1QbKFTRgB
         1m5ZSR3cpDuIV8E2RAIcdkBAGRlK6qug+7kti6BP1GiieWk2CoZMDE6xx7P+LCSgZMUc
         iIydnpsR2ngcWcGCc2DPwo4WMDoUt5BttIzQ/zP6r2YeSvIFx5LTnoENw9RRWsnNhXnt
         wkmA==
X-Gm-Message-State: AC+VfDwU2fPf3+vYP9HaEMjuR+mWb1jdbOm3rtvDm3YUaEzsvb0wKJ+Z
        IU36Kw+85UBa6zCqCYyMAB+QYDq4VV7hYr3rYU4=
X-Google-Smtp-Source: ACHHUZ4ht3YIiQ50e8huJt2XxdPKH3NDmiEMRyFqq9xXTdAkUC6C03nSsn3iEVOSU3w1gmk1o/YuGxesawPWwGdqCtQ=
X-Received: by 2002:a0d:d401:0:b0:55a:a9b6:6da with SMTP id
 w1-20020a0dd401000000b0055aa9b606damr22977371ywd.11.1683827473537; Thu, 11
 May 2023 10:51:13 -0700 (PDT)
MIME-Version: 1.0
From:   Charlotte George <eventdatalist6@gmail.com>
Date:   Thu, 11 May 2023 23:21:02 +0530
Message-ID: <CACS77DVEqswLstbHaU395iaB=cfYBqD4GxhyMPVm_3-t9jrZoQ@mail.gmail.com>
Subject: RE: ISC West Attendees Data List 2023
To:     Charlotte George <eventdatalist6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 I hope you're doing great and staying healthy!

 Would you be interested in acquiring ISC West Attendees data list 2023?

 List contains: Company Name, Contact Name, First Name, Middle Name,
Last Name, Title,   Address, Street, City, Zip code, State, Country,
Telephone and Email address.

 Number of Contacts: 34,526
 Cost: $1,789

 I appreciate your time. Looking forward to your response.

 Kind Regards,
 Charlotte George
 Marketing Coordinator
