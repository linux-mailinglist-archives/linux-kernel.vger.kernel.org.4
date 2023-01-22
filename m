Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BAA6771EE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 20:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjAVTdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 14:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjAVTdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 14:33:45 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7081A953
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 11:33:44 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-4ff1fa82bbbso98485647b3.10
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 11:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=svXPmt23TZWVwk4XM9rjbwALFmUKm8hJixbFuvxTezU=;
        b=oVlmF/WtYmELO5oULRwrjz4t6bXrTqDDjnwA52TA0ZT4BPsRH9W7CJ5vD7uP5yyuTL
         ksCP+9C+X6uFhYDHs5Xj7CW6RUOkOU9aUGMdP0TxGJmSjl4l5PqVwa33zXP+PJ6IrPiw
         741KgHYoURnGURbgMT0T76iiSk+Gm1fXSd8xAujjvL/a6MAJZcwbVrDcyKCuoEmU5sfS
         ODJTumYw/7rUfZyIQFq9WA01QMGLdvfTxdmkLVRokaD0B0G5s8tm0CBVRNjuDHG++5Uw
         dCiYLv4fuk6vYwwPsI2GS2REhNYUOgLgs+3mpvZZjiDUtSWe5jBJ5fybIGb70u0okwZX
         08uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svXPmt23TZWVwk4XM9rjbwALFmUKm8hJixbFuvxTezU=;
        b=ptPXfpk6CUTxdhcMPXlyj8eudMwHZsfX836J67LDUlc7eiFrsXBtHJkknPK41Mlh/n
         LS8nLiPlE58KXUzltuuavhoZlg0GcDqU5LGGABUpGcJiKTFfzDnMIB4JChiNjSpkAgBh
         WgGqSGwoHjBSPlBeaj6XK/6OCiKI/Re0Qq01MHCbn+bnadYqfcVnwqdddXp/NokjvZ8a
         M+PJknAWsNkasJrjQagEkSuR//9zmYV/pktY/j932vsb/xA5p9CDLjCE8+qCIXRxuxg+
         sPIvbQfR6zIHq+0c7L0l/Uj49ZktbGiIPpFovEEFMI1Yv2TWFCWIhHmXFFLJfJ/qXMrB
         1PwA==
X-Gm-Message-State: AFqh2krU5WcsF1TGRonLvT3BlBn4vJ6CpXnaH/S/j7riKPMZjSw2oWBW
        cuOqAqr7bHGDEPUaeQqYu3uvWKH59/OdZeu2+0g=
X-Google-Smtp-Source: AMrXdXsMDj66QCZxweISSp787ufMNtC/QM9280TN3P3geG0d+79yBymVcpDkmufamNss279eiY0DRMR1eELBn/qAJRQ=
X-Received: by 2002:a81:dd6:0:b0:4f9:dde1:ab12 with SMTP id
 205-20020a810dd6000000b004f9dde1ab12mr1756485ywn.296.1674416023804; Sun, 22
 Jan 2023 11:33:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:9b83:b0:427:2c85:d41 with HTTP; Sun, 22 Jan 2023
 11:33:43 -0800 (PST)
Reply-To: abrahamamesse@outlook.com
From:   Abraham Amesse <bartolosimon102@gmail.com>
Date:   Sun, 22 Jan 2023 19:33:43 +0000
Message-ID: <CAB2yXNDDTVHYirLMiLZpFTVXe22k+Re-dagpwuQEn0kV3Dq03g@mail.gmail.com>
Subject: =?UTF-8?B?Ly8vLy8vLy8vLy8v6rW/642w7J20LA==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

6reA7ZWY6rCAIO2ajOyLoO2VmOyngCDslYrsnYAg7J207KCEIOydtOuplOydvOyXkCDrjIDtlbQg
64uk7IucIOyXsOudveydhCDrk5zrpr3ri4jri6QuIOydtCDsnbTrqZTsnbwg7KO87IaM66W8IOqz
hOyGjSDsgqzsmqntlZjqs6Ag7J6I64qU7KeAIO2ZleyduO2VtOyjvOyEuOyalC4g6re465+s64KY
DQrrtojtjrjsnYQg65Oc66CkIOyjhOyGoe2VqeuLiOuLpC4NCg==
