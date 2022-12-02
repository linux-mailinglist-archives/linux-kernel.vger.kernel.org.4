Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC6064086E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiLBOag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiLBOab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:30:31 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02560DCBCA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 06:30:31 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id w129so5057875pfb.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 06:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QuJaADLy0s4fSOAHYyYcKJlmR4N46y5Ed14w99UYvwo=;
        b=baoX/JUMA+VCZMFwVNdxGizr15gJ9t9RC7WarFpyNNajaYguEpJ1Fgi5LCPLcIBK//
         R/+ucFErE6Jvxdt8emlT/KdWL7DxVIL1SU4eWJvfKnRZDC/OHXPUrOr13mtPdzTaaMde
         a8goDCNg+qyvnJBH4HKe9xgIWx77VKs6dCqslq3K5Tw6uzDoH9r5Tqo3LuYBizUOe+G5
         8rdK7I+9g/rsMQi7qldPI1Y3d1WloPSdwIn+6lkRYHsaiNeufZSNOrl0VBJ9qzCOEJ4d
         +HkRa9O2+AzS71ituxmPRwCLD4zEQv+OSkgVOmhgPCIoPArlgZ69NYvQxCBFLsLEALde
         hPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QuJaADLy0s4fSOAHYyYcKJlmR4N46y5Ed14w99UYvwo=;
        b=GCi6nV7e6tacAWbPczn5L7xLnBL0PXwXx+vrsAbB3N23bXRTSldz/Defd9kcX83RhR
         agwiZADNUtYI46EmrJgaAUA+roQRc8Bo22rGlgcihBACd/Wi3+9ZptWZBew+dMdgPi60
         OenyEMWe7/t2vY+6XtzqdU7AQ7Sxuo2N20cbwV3RVG1TXmxMIOwmOFMobvmhlLlYsCjn
         JyrsWWDhIz0qFNaapGtGymMf4rr60ZAbilDx+TLPpHPFsKqUhWMEet/llPoPkZ0T7OgW
         ggfGTV89qospRasi6/Da6gAQzkeEYqmfObU2m7iGEXHVcwfz7gExaZMC/hBkrct1SXkg
         GD3Q==
X-Gm-Message-State: ANoB5pnbIXsm11k+7uzFdnTatC0QSQD+YohsMrkqvNOmmFb6vvcXJwD5
        DZkWSnuZ09rDm51u6JnXqddAGHB9oeRRon1fDM8=
X-Google-Smtp-Source: AA0mqf5GNZcKuGv+DNDv/jODPv76iAfkuwY8Wz8ANYFgCLAdM+yOKCY027FOphHz9ctF8zQ97wfWbGev9lJAs5z9Mvo=
X-Received: by 2002:a62:1d54:0:b0:575:5cfc:d905 with SMTP id
 d81-20020a621d54000000b005755cfcd905mr21749428pfd.69.1669991430416; Fri, 02
 Dec 2022 06:30:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7022:2492:b0:46:f45c:a828 with HTTP; Fri, 2 Dec 2022
 06:30:30 -0800 (PST)
Reply-To: chuinh021@gmail.com
From:   chuinh <gimenezmarco201@gmail.com>
Date:   Fri, 2 Dec 2022 15:30:30 +0100
Message-ID: <CA+cx=QmYMnKenpYZPuO4upYuo8ex0-kuUH=QVA7xSmoJsrRYvg@mail.gmail.com>
Subject: 
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

-- 
Dear Friend,

I have an important message which i want to discuss with you.

Sincerely,

Mrs Can Yeu
