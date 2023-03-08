Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086A06B0C3D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjCHPKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjCHPKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:10:10 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E9716881
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:10:09 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso1557960wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 07:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678288208;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CpL8pfFHgYoyZ2Mo0Ft2NbfXGys8eh5PDeoz/LLjCnE=;
        b=gVD0r8j9Z0fi7pW1CicsKtp2RU82Srt077aqkc5hTugpF+eCm4PHRy6vhXvL43MrRv
         HEeY0/TKYoswgTPs1d2tFAvVaIXmQ4OrJicKUMPCgcp1KU4zx9bahh+V0hVHWPhoCe+0
         K7KwM4IELDg8Bk3T45Oj6pdociyUFGmZQfybzi4g7XT2DRzd6Prr9cIrbCvSX8ru/JTC
         OYc9bqer3lnoS3mX82JFMdRnm2REsmRym7GiBZPzzbmXh6uXfMovD3eAH4+qVwIL8tq/
         Lur8bYJ8FzgPNrnr15/U+eHwXYg+BVcqjKMsHPdwVqjCgORvkdoNK4TQSy8TcYrYZY4m
         I/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678288208;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpL8pfFHgYoyZ2Mo0Ft2NbfXGys8eh5PDeoz/LLjCnE=;
        b=QQaYUdEY84DxizcJhPTY0fYT3vM1JDHuNue4VmuWnFUXbe+au0LI9Kj207o76BQFWu
         bnT2in9tPJc2/HRn6NZNlxBLGMUqM50xvCvMttVcfLDC9tCkm10g34nMZkgscuIxfvwn
         hcz/tF9pWmf+4N4mLDcOt/GjIONiuSrozO9Au2or2NgajR9Pn8bRDzbBZQ9Z8EXbG8Th
         rMp/0KUC01KpvWVvnnJqzoC/tmHqfoURh95/8cIDwR4DVJht/46LIxoutIa9SJSkux9I
         6oa+upBBBCB3xmg1nXWpgP3LplRY6RyMnpJuIjoAi2MHU3G4sedNXApwdbWte9qUut4F
         i19g==
X-Gm-Message-State: AO0yUKWY51D+tb9ahduImSrVzUGD2Rj+41VT97O9ssf7ruRbxVrnuK0V
        TSFaR5lcXhomIYg4hSpeTuGki5cF7vw=
X-Google-Smtp-Source: AK7set/eaO8GrdVjgOGC0BJlLMKMjS5m9txtEWuIGl5bqqq6VhtuKxEj2k1iKttAnQnubBizQnUJFw==
X-Received: by 2002:a7b:c5c2:0:b0:3e1:df8d:e022 with SMTP id n2-20020a7bc5c2000000b003e1df8de022mr16830898wmk.9.1678288207728;
        Wed, 08 Mar 2023 07:10:07 -0800 (PST)
Received: from DESKTOP-8VK398V ([125.62.90.127])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c351100b003e4326a6d53sm21705718wmq.35.2023.03.08.07.10.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 08 Mar 2023 07:10:07 -0800 (PST)
Message-ID: <6408a54f.050a0220.cc599.456e@mx.google.com>
Date:   Wed, 08 Mar 2023 07:10:07 -0800 (PST)
X-Google-Original-Date: 8 Mar 2023 20:10:07 +0500
MIME-Version: 1.0
From:   terenceblake6795@gmail.com
To:     linux-kernel@vger.kernel.org
Subject: Bid Estimate
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,=0D=0A=0D=0AWe provide accurate material take-offs and cost=
 estimates at low cost and with fast turnaround. Our team of prof=
essionals has been providing these services to General Contractor=
s, Subs (Painting, Electrical, Plumbing, Roofing, Drywall, Tile a=
nd Framing etc.). We offer both Residential and Commercial Estima=
tes and we cover every trade that you wish to bid, whether you wo=
rk with CSI Divisions or your unique classification. We use the l=
atest estimating software backed up by professionals with over a =
decade of experience.=0D=0A=0D=0AWe are giving almost 25% Discoun=
t on the first estimate.=0D=0A=0D=0APlease send us the plans or l=
inks to any FTP site so that we can review the plans and submit y=
ou a very economical quote.=0D=0A=0D=0ABest Regards.=0D=0ATerence=
 Blake=0D=0AMarketing Manager=0D=0ACrown Estimation, LLC=0D=0A

