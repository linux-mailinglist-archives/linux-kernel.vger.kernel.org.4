Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8259269AC25
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjBQNJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBQNI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:08:59 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26C367452
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:08:58 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id c10so1007148qvp.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baWonEXSb/K4v/yFSvVpNeU0JFI/BWw4Lj8lad4SY58=;
        b=jPADiTFx2QrwSl/ont7spbIyCTP5MOgbo/3JAgJFUC5fxrD919ZfxtIjP9OvDqUUmy
         Tmni1tJimO+TT+jr0mZjYlQ0AhqoMeX3Lnv02AVq6nytsoxmKu7iwoQxqLuNI/1IxiuR
         NRXc+RHJ6+jk954jtlXjHqWHcTdABuSjxBSuMylWt6b7xAIqG/4GzmooMiOBw9bu4Eh6
         NIaUMGzfuJ3e0j73C0kFkI++9OhpnQ28o/VLGjuNZYHCtSiN9fxv58aX9kb/4/5k2o/L
         CbWS5LDETkMcZiQws4IAQt+r9SGs792b08YEB1humtns9gmByHn1WCYjqeNVqp/3fEWg
         evIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=baWonEXSb/K4v/yFSvVpNeU0JFI/BWw4Lj8lad4SY58=;
        b=tFzQaEaRlSjugi/pRJoN1Ax+RSeEqIn6o3QqB5fPoOcdYlXypc6ip1+f+k2uo2oyVT
         NbNaYP1Wvsz2aFXfOy4p6bZQ5f2x7JEBo5ZoUH4RXA08/zT/kaRs4KvVTQZDnnNu95ue
         MAB0v4vkvwTUljG2fU+wcUbY1tAZpcMb+Gahl1wPJP/XAPGRPMQDn7B0ZiL6+eQxjmz5
         K1Ty5bcb5uaeE7iOtwH4UiNv6EX8JaDJC7S6x2PCzKBpguHJxTHJ+beOxAkzO3eCZ2gx
         MZ/+HxZlV1PPHVtfT2m0DmsSHwLWScvf40Q8w4DGJem+KwasANZyZjDS5VGlTkvtrEAC
         ZQCA==
X-Gm-Message-State: AO0yUKX9ODCmxgN3zLqwkol3iulM6CeM1/+XNHNw8p34ufRTgG2SrRM1
        CT9gMZVc7i+VwxE/zq8uUAWpfKTo8mA0bDPY06A=
X-Google-Smtp-Source: AK7set/EviJ6sMoaxFP6CFLWVNuHQFbops8SkJwnhmZzK2fOqyC2HBGDibLdkFx+0EYGOvYYbV1osr4MPh3faSGsIfU=
X-Received: by 2002:a05:6214:aac:b0:56e:98c8:5d69 with SMTP id
 ew12-20020a0562140aac00b0056e98c85d69mr147744qvb.8.1676639338081; Fri, 17 Feb
 2023 05:08:58 -0800 (PST)
MIME-Version: 1.0
Sender: guche211@gmail.com
Received: by 2002:ac8:1004:0:0:0:0:0 with HTTP; Fri, 17 Feb 2023 05:08:57
 -0800 (PST)
From:   Anthony Kwami <anthonykwa900@gmail.com>
Date:   Fri, 17 Feb 2023 05:08:57 -0800
X-Google-Sender-Auth: 2sg-NI72CYE5BzND1jCVXzU6Kf4
Message-ID: <CAGV52sTDsnpThFpa+mvcig-YmDGc4yFKf5GDSdNkWPdz8x5FMQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have something very important to discuss with you. This is an
essential detail that will help you.


With regards,
Anthony
