Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269F6714F85
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjE2TBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjE2TBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:01:32 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91045C4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 12:01:29 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-557d4a08bbaso2056579eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 12:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685386889; x=1687978889;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbr7vZiwx4QOx35ITuO1SEVHfkSNAhk+9ZBn9uxkxbM=;
        b=mAn31QAXvM5Wu5aCLD+2W5RzPRucZuN3RE08HxxLhD8EcvZ9q0sODgS5holbF4vRa8
         +cJJIUkC9ISoAW7/l9FBGnzMZCIBEM4SgNIPNTgjLm4xv0zuwY5/Qo9SNQRFHBRaJEd7
         0G1+qv6KyC1OZ1eA612wuKEGx8LeL0eB0CsLHHKzk+7Sv7CjeUMahjppL7RmKSMCizSm
         TWUKylrzVLdcyFK8WPFKKSo0hCy3XUOCWnc36zVfAqVai5rEh5OC8rtfUa+5Hm60KMpp
         FvyWdB5Qd7OQ11iO11tR1vPnoKKXbLuKR9LjoTbzLygHj4Kplo1h4GHNpx6NcCo65K0i
         BZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685386889; x=1687978889;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbr7vZiwx4QOx35ITuO1SEVHfkSNAhk+9ZBn9uxkxbM=;
        b=EtEMda/fsRzY59PgXrJ969B3o4qvr9IATBMT6BuT6eJMwTtW47HFeGfhJD7DpmYG6R
         AEqTNSBZETv8Hwm9D2gRIoj1NJf/M+M1OCE3zMkph2+TEh7DFC3DVVmV/Bmq7n5IIZZu
         altn5gGQp31QmBFQqaijLTwQwWECiRiK7ORH7OTsgZhw6ePdSAcJkQ/Nv23++rPTw1ai
         EFV9UXUG295KUgrkpgwa4a3/AyAIpbl78MT+/kP0FsFy/g5O/d1JsoUNGAPvhHSncnci
         7cyZPe+U/W0OxgUzxa6uWSgoc4du7z4ewVuQG3ojRee/xRtwgCxv9XuV6ctGdY9cUT6i
         ReOg==
X-Gm-Message-State: AC+VfDzhJEwgBARm4wDoontVLpadxl7h5Uij+N2SQ4FBlbGRtbD6YUo2
        H3Qxe/KABYixXbR8lRmlAs1phMTxlLhlehoA5fQ=
X-Google-Smtp-Source: ACHHUZ65Qf1Tt26fwzXA+nIqoTg3pVfA6//2QmYAatILmMxG+zr1iiSrtgC89jGY3QjJnOvEz5T1iIhwgAgShQ4GKNk=
X-Received: by 2002:a05:6808:1b29:b0:398:5a5c:e89c with SMTP id
 bx41-20020a0568081b2900b003985a5ce89cmr6369927oib.28.1685386888914; Mon, 29
 May 2023 12:01:28 -0700 (PDT)
MIME-Version: 1.0
Sender: dwellsmusik@gmail.com
Received: by 2002:a05:6358:428f:b0:123:3afc:3d12 with HTTP; Mon, 29 May 2023
 12:01:28 -0700 (PDT)
From:   Maya Williamson <mayawillmson@gmail.com>
Date:   Mon, 29 May 2023 19:01:28 +0000
X-Google-Sender-Auth: up6LVTjwO14CarIElbZcV_H20Ck
Message-ID: <CALH7ZXju==kgz-QX21JSid2q9q15N0S6qvFnFxDpMGnDhxfqdA@mail.gmail.com>
Subject: re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
I'm Maya,
I would like to talk to you
hope you don't mind?.
