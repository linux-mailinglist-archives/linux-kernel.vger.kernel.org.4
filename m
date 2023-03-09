Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BAB6B2402
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjCIMUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjCIMUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:20:23 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D14EBDAC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 04:19:56 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c19so1609784qtn.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 04:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678364394;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qrlWvAgXOjX2dn30mYE0aepzVc7Nnh0ysWT8MvEeWQQ=;
        b=cmo9u4IUYoP336iGdu3RPxzJLEHRw/wpBgZ4Y7AFPA4KXt3uYBQuEDQ2Uy6JB8NL2y
         r+/1BfspKiOc0/gVXuxhkrfrGYhmrVD1PNQ6aagejZn3eGOtWBswL6t8Ml4AI2T6or87
         brfVWHtL020ckn14JfaMO9K/1a5okrndeg6T7aGcJ4RE0pmrJ7htE8KyX/Sf5fN+E0tu
         EKCbs7d3t/eGBUzAcMrBJ23IGyUw28X12piZntxEWo/5zY0kwf0mKBdLmNK24d6qo/Hk
         9eeCpJD4WPGEyXb3Rj73JKvtJcAl5kzEe0zdijczW77mJAlU1T2c7qBdDo93CEn68JLR
         HAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678364394;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrlWvAgXOjX2dn30mYE0aepzVc7Nnh0ysWT8MvEeWQQ=;
        b=ISom0fhjJTe72WD1786BJy8noNbNulXcddBysGzlP7hBjeEkQV5DLtomyiw415uc0d
         xdvP7IRenZ9QtAHLyaMJckVJYA/GuqM8aJd5WRhzROF1GczVDElD1y001nDl6Xzt75TS
         fZd91iJtAV4B1LtwkakjUu4x8sEAecOyVvAhSUIFHpvw7Wbvw8dfjJoRziRKtVqlBV8g
         H/qFU7vjqxqmJ2x7XUI2Td9mWfOeQ0hKPLli3oIcFY9PkBQmXzlsc4g5cpncoeB9FSt2
         IGqBOxSZJeR37JN7f4sPOwsNqEFBJz6lfPCZNSiP8/qhb1tYh/bOw9Drp6lYK8rgS2Zd
         xYfA==
X-Gm-Message-State: AO0yUKVOquoXeypz+aM7AN18aOiE9eXS6V3S/g4LehG0izshhIs2FLaM
        6huDd8qQpzb2g5+vaM7781UCkleqk3xuh31WMR8=
X-Google-Smtp-Source: AK7set+0lvG0c+blSzRmxGrQvcYOLx9uRQAp1XysImOdNpc+B5zuEoATDL+lW7FCNp/P4NqZ8BrntWk+DbtKT71uzoI=
X-Received: by 2002:ac8:4155:0:b0:3bf:d520:1d57 with SMTP id
 e21-20020ac84155000000b003bfd5201d57mr5827606qtm.2.1678364394437; Thu, 09 Mar
 2023 04:19:54 -0800 (PST)
MIME-Version: 1.0
Reply-To: vandekujohmaria@outlook.com
Sender: leet21052@gmail.com
Received: by 2002:a0c:f04b:0:b0:574:2243:21d0 with HTTP; Thu, 9 Mar 2023
 04:19:54 -0800 (PST)
From:   Gerhardus Maria <vandekujohmaria@gmail.com>
Date:   Thu, 9 Mar 2023 12:19:54 +0000
X-Google-Sender-Auth: V6kXdklkHdksQV3kskb2chUgpEc
Message-ID: <CAHPFK84VvJTQZjrWsuZUWVjkrbJdmHtBmw+t0_eg=rqDTZRRwA@mail.gmail.com>
Subject: Donation
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear

Hope all is well with you and your family?I'm van der kuil Johannes
gerhardus Maria. I am a lawyer  from the Netherlands who reside in
Belgium and I am working on the donation file of my client, Mr. Bartos
Pierre Nationality of Belgium. I would like to know if you will accept
my client's donation Mr. Bartos Pierre?

Best Regards,
Johannes
