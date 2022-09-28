Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED975EDB22
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbiI1LGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbiI1LGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:06:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DF1FAC7C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:03:19 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so803902wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=dswzrHyWlFIOKHF2fLmgLiJS7Gb8005fvifIB4yuJASyKlVGlNwRT9iFRPNYrPxBil
         C8RQSFAkHDjzvG/Lkl+PvaK5l77+cxNNsDmkiqk4f3cNeLVm/51RT02R8N9Of4eUwuhz
         CBI4ArJ+dbZzrXPkfeCk7u5Mj/6HZivOl0JDEfEUpYpUWeq82KpJnj/vzHj3C1pBF1gD
         QAjjG0SfFrzA6bMfaCUcMzvFCc0nzUq6iHeUhka5lIeOK9U2J+zzo37t9nGHzDS5fqFd
         bYlWko0wwhNPauh4GaSaMGEs+LrOtG6a3GdOylaWtYI/7m9/CY6K/tUm5olg6YiTwtRU
         XDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=r7EXvo4xleo4vt64XtfFCWy7m9A8w3tXRZQXVPAuIdOiG0k8N8/Bu8BULObz/xiLLz
         h8uH7LjLGi3me/sKSaD34g1zj3C3GSbWjHTZ490D/czKUoJ9h/EqDAfsCq/dEVBcgOth
         WKBvnkifzwQhbLnZAWjiQjAuyE6kyskzVdtfpAEcwEmBEqt9StRPPuiMiJ2v3jR6ZbEi
         T/B6bWujftoEpHN1wrXmVr55aNuLeRxkz3KKCCylnNGy5StnBsLpEAdo3D364XvZJQyQ
         ArMTwjJi+pcPo4QhFjjeGle9nis919BiJnhlVwkgbbvSfCv1EbPvFMLcs2DBDT7qjIsw
         uQgA==
X-Gm-Message-State: ACrzQf1cmuejwfX3facexXuGfY1kdyV5o5fAuFw8sNzCP5TuF5Gqn5pF
        txfCUnyC11y1Li0dBmlILQo+eNa6oTUL6KTtZmw=
X-Google-Smtp-Source: AMsMyM7HK4X9SqPRMqMky8GstwBujzQsfTJb2UgOCO7L0A8gdjCQcFd3/0ZWFryD9PgbhtM9jVW2l/4uXbNg89ws8Sk=
X-Received: by 2002:a05:600c:1ca0:b0:3a8:41cf:a31f with SMTP id
 k32-20020a05600c1ca000b003a841cfa31fmr6479890wms.161.1664362998113; Wed, 28
 Sep 2022 04:03:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e242:0:0:0:0:0 with HTTP; Wed, 28 Sep 2022 04:03:17
 -0700 (PDT)
Reply-To: linadavid0089@gmail.com
From:   Lina David <edithbrown052@gmail.com>
Date:   Wed, 28 Sep 2022 12:03:17 +0100
Message-ID: <CAPGw1A6tJK70vAQ+6vJLQ81kcdvghGthuK6CBouOm-cC8vBj+g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
how are you?
