Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F278D648387
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiLIOOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiLIOOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:14:03 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75177B61
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:12:09 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id q7so5034259ljp.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 06:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=h+drBxOeSJigUA3MLUjSIQkaxRy31By4uzHNDDoF+eKwOCHvB/BZ41golKFZ06kt2O
         FOju8/iENFAwcSmUtdyeMc/WxetyhYimeTCPs8SDK34hmIDmce+32IqF7ljecOIZklqH
         JVJUilO2heWVwgaapCAtyP7QZLZicZkgxrqxiJco6eqOAMMoDjH7vsS3ewuSGF/tStTM
         Bopp0Vu5842U/6v9x9fChmCNfXUuovP5+yHq2LIwuq6+9JH9IHR4YKP62OFIj3zSYfKM
         2yDA33UaRDG+/4IGxThBXRysLc1Ig0CQaMsRCIWWtx3wh7hUYoTmwN/fw8I6hjrYpWMS
         byIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=nB6L7+1TQUeMGxKrnO5FBhYuQd4YsQpljY7L1OiZk/kwJ1MByaEYBST8hvBBQ3xPgY
         P747Ux4qCnPAVP6sgWY8ApMyVDSMT7pYjZiqHfpZxM1H3WyoWdCW5Z9KmrU6HB/a2Tqh
         CpW6+7/lL+aFbFrr79ghpkISRZHG1mEKkT/CNEuSsgsKEbcBF9zAZ9jcLw8QSg5XTU/5
         E7+jskxK7a+JcbQsUshMdFamSMVAA13zETQZfkIOsiVb+CtWut7ZyRDcj4LciPWLUS77
         Wa29OwL0IuUgsRpjgxbjdsZkpQQ1DYY2qt+5wzXsnl1aKaekgTdX9llqZmmgKUAQK8yw
         6WfQ==
X-Gm-Message-State: ANoB5plrbs9UgWxM9OLUF2nyQr7yDNqukJGoi2TubjhLWCcmMQTgTUju
        tF9owwMMo0Hk79G+i0u8iefli25tzajs1fKwJc8=
X-Google-Smtp-Source: AA0mqf7jksL68rK8x9YGXrEmQgEddYNaeDLj+F7IA8QyrU11vDwjAVeZrven3MdF9GJL2HIfO255QgBLpC+YNXuJzDQ=
X-Received: by 2002:a05:651c:b14:b0:277:7eef:1d97 with SMTP id
 b20-20020a05651c0b1400b002777eef1d97mr25542914ljr.516.1670595127652; Fri, 09
 Dec 2022 06:12:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6504:51c5:b0:200:568c:e6f4 with HTTP; Fri, 9 Dec 2022
 06:12:06 -0800 (PST)
Reply-To: subik7633@gmail.com
From:   Susan Bikram <bikramsu87@gmail.com>
Date:   Fri, 9 Dec 2022 06:12:06 -0800
Message-ID: <CAAki5K-sHve9=VafKRooQpNiJFQDy_tb4j981-memkEYtvRsaA@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Dear ,

Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Susan
