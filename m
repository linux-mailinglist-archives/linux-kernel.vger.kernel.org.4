Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F8B6F04E1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243152AbjD0LVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243418AbjD0LU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:20:57 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726D359DC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:20:34 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-77a8cc70fdeso802042241.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682594428; x=1685186428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SxCvkt1t5/3KLMQ59Hp18Juu41+75fyuKvnY3ccR6G4=;
        b=C9urYLtXOBflCCUNiJ7/vRmZDHqMTNTcoH67UFDCIbkaA8yX8N0o5M+syDGyAxC3Xn
         DvjJYx1KqNAyRga/fqiZcCse2+zi6YCUcl4kBCbhEcDGQ58auZY6GIOV4D1Uttgfl8o4
         tIrg4qdGrf+7Hfor5FqrE6D047yatNMjra0jEEGMY0fU0Cc1mICCRuq+Q1I8GCk8KKsB
         Jn0PRtETkHtFYCCGlkQliJJxvonXxvUTA19RKGF5CadezsTiHZuxSQyJHY/2nlo33zsa
         pWtcE75B1dBkUGNxQGOEYS452bNdwqDq6tPoXAvdsFZZCyA8NiZgj8zw+lX34BF5U9N5
         JqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682594428; x=1685186428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxCvkt1t5/3KLMQ59Hp18Juu41+75fyuKvnY3ccR6G4=;
        b=ibVJNc1GqhxmD4gpl8Qwv9+TbeAfgq/DJLQytCAMHHiqf/5P8Dm0EWfp+pZsizHXBx
         ArKJ4arK6836gr4jujphXHBWfsQXwPchu9evfFrVpdayXb9YUpuf0qmsCGS3nuLhdoNY
         jmYL5zQc3ZpPXPpy/ecT7upGpfXGsukl3uJ0TwRkTXTRI+jmzp9wQ28XvJK/fhjKfNli
         y9eqIfuE7bbIxEdrNaoHRWWGwE9DM28qqRhkBhbkGH/OVwPCunKnBjHghFwklbOE72gf
         rNno+5/ep0jfEw3UddgL4qYYmc+LE+gXULnOWMetzMIi/hA/hiyFi0PUsW+eJ075B8lL
         tH+A==
X-Gm-Message-State: AC+VfDyR5fJyWUSt1SJCrDgU9koZFZm86Upv5xYo0q/HKTO9y7Z5Nq33
        NiPcNBFO4GTFf/VLCVo1MwRBIJeSZ6aLWNG6C61FPkru0iAyhK0f
X-Google-Smtp-Source: ACHHUZ7pP2D/vlhEtfTn2rE1xjsLfDlx8m7IS5wSAJY+xGGeHIEfxM3wITJuLURhJCH5XnxLPcq+5UYIi+ZBmm/ywEc=
X-Received: by 2002:a1f:5cd5:0:b0:440:8c8b:6a45 with SMTP id
 q204-20020a1f5cd5000000b004408c8b6a45mr314548vkb.2.1682594426369; Thu, 27 Apr
 2023 04:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230427023345.1369433-1-brpol@chromium.org> <CANiq72nxNtLvx1J-50F8D05QQjx4FBPkrhg6pysc25RL6--Zhw@mail.gmail.com>
In-Reply-To: <CANiq72nxNtLvx1J-50F8D05QQjx4FBPkrhg6pysc25RL6--Zhw@mail.gmail.com>
From:   Dan Carpenter <error27@gmail.com>
Date:   Thu, 27 Apr 2023 12:20:15 +0100
Message-ID: <CA+_b7DLoTEn6_2auTVN9Wj62ogOFXnhf7kTmh_KCZPkCBfJsSw@mail.gmail.com>
Subject: Re: [PATCH] .gitignore: ignore smatch generated files
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Brandon Pollack <brpol@chromium.org>, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
        keescook@chromium.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for this.  To be honest, I hadn't remembered that Smatch
still generates trinity_smatch.[ch].  I would prefer to just delete that
stuff.  Another idea is maybe Smatch could put everything in a
smatch/ directory?  That feels like maybe it would be nicer?

regards,
dan carpenter
