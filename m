Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEC068F99E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjBHVRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBHVRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:17:52 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A79432501
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 13:17:51 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id h24so363207lfv.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 13:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7K3SdsX+o6Xs8DenIJv/GPl3eqRlM7oJKb2XOYZBFDs=;
        b=D+ikUZbWgeUudplA5po5W5M5DxMh/6Jj7uZ7xBBpP1mIyMfKrZtcU86MtTohiWsoE7
         V6rxZrRkUhgwDDElEuAYS+r1rkH2Yqe3iVsRpWQkmb6Eqi3MCQ7kespJEMYz3UIKv6gF
         y2hX4XKoO/MSV16sGSgRyQymVl5N1IigURddMk+WzFE3fKX2cDcGAIWkpuCcEG9OuNxh
         PRfRRlN/J8J24ii38s9kRABckLc7fgwCv5K/20u445+dDNpsvo7rZaqSVFbgJqrHh+Dm
         jiUCBOlkpJ6bLXtsIN2Rz/CnVZaXjYAHmERgNQ8Zx+n11GMtjO++fG/rNMaD9sYf7mjn
         fQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7K3SdsX+o6Xs8DenIJv/GPl3eqRlM7oJKb2XOYZBFDs=;
        b=GZccR7VhsCyA+WgmR+EH2I0Zjyx9sMn3cZAMo36v+4NLe2X/E7gzqVOAMUoMZMZW4G
         bFgwNE8n6VIGITSHSidmkijKFMvHDgF4GVlw6UlYGc9yXtxTH8Sk3kNiqt7dK1FC1WcE
         J+7fvU+ofQHHVJRWSFxC2lXo+dPs7TrDB/tWfj4A/yVfR91pge8wu6GaOT8QGd39Tdi/
         qTWaPDIvwgKAiacMLKOOT7dx80WdDdELUnqJ5q1wwRmp7d4WqRzqTE75gWmy6xRinh9Z
         eu6kuXmEvadc23aRyBAOaJVZhVINdYFHJwQO5NhrHWHE4kgOJtEju59kRURUYOKRBH3j
         +YHQ==
X-Gm-Message-State: AO0yUKURQ9Oo5d6iRIWHe5QZ9geZrEDBSiMZ+C6hFjmyldOamj3L4KJ2
        J1yucAIpYy7o7TL+xn3ZN4+90wApJw2Cq4uAy8JcZY1Rz5RxKA==
X-Google-Smtp-Source: AK7set+N6ero7aIdk0QcVk+kKKwUN65NMfSrpAXIHmhWGjsbw6ACdMLdqJhFGUJloDYiCTH2v8kdUnU5DyaqCTaelzU=
X-Received: by 2002:ac2:5594:0:b0:4cb:f3c7:7a52 with SMTP id
 v20-20020ac25594000000b004cbf3c77a52mr1497960lfg.193.1675891059094; Wed, 08
 Feb 2023 13:17:39 -0800 (PST)
MIME-Version: 1.0
Sender: mohammedaahil30@gmail.com
Received: by 2002:ab3:7303:0:0:0:0:0 with HTTP; Wed, 8 Feb 2023 13:17:38 -0800 (PST)
From:   =?UTF-8?Q?ELIZABETH_=C3=81LVAREZ_GARC=C3=8DA?= 
        <elizabethalvarez7garcia@gmail.com>
Date:   Wed, 8 Feb 2023 21:17:38 +0000
X-Google-Sender-Auth: hOHP1Ys_AfYTAhgHVyPF3OeB-Gk
Message-ID: <CALoWANixkoXQtFT462Oho34Ad53NxxVLuWPv853KsY2f4LuYzg@mail.gmail.com>
Subject: Congratulations!!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Congratulations!!!
This email ID was picked among the Coca-Cola 10 lucky Winners,
please contact the agent for more details and to claim your prize.
Thank You
ELIZABETH =C3=81LVAREZ GARC=C3=8DA
Public Relation Officer
