Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408486396A6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 15:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiKZOvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 09:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKZOvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 09:51:19 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716671B78C
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 06:51:18 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id k67so6668593vsk.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 06:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxtcOuQmPsKX/VnSBQUH8M518AMxfJHchjU0WYEzOOQ=;
        b=mLQ9bvMA5h8UN+I+/CO6xs3DRYiyVoaGnAzCReZxhMmt/3JP8oj7raNWD2lcTpsX9z
         CFLxkG10tR408nnQ1aK5Z61uGG7KUP0s9NoHr7hhLekWoDQvpYGEWrgfpSLekOY+2OlW
         lCi1Y/JxjSXyZFneymSYOIVVTZHmffuBx+A8FFV9QekGEvK7h53UTCXJIGWAdtTIvsyo
         PgK/2KrG2iLovdLTSqBzNfJcsx9zw4NLW0f/zeo/yeeVSVd+iDF7WJ9LVAJS0yrK+F3n
         x2MMehhirnxorHf5zb6b534B65DV2+SnX/+o8PBD6GphltjCoBBnXLf9Vp8caJjypKCN
         i1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxtcOuQmPsKX/VnSBQUH8M518AMxfJHchjU0WYEzOOQ=;
        b=wOKFM6ANiyRw78yEKkLx8PeEzm6k7Wb/DqNnyheiCxp22b2Vaaw+qDuOsGJTSSNK0n
         HfO3iq8xada+pIs11VJQuK9x9/lBkl5ac+hHRuiOsmCxWJAgX6O7L/Aw8BzTFwiwTpbz
         fVoFw3/nQLkq6ElySJzbhe7Gp0qX+uikZMXodA/6CzblIlHGtUSQ/oBJxgAm+8ZIVIdJ
         svUlZLt5FXp6Xt4zr6DYHshrL0YAQrOz749YNOta4YpEPqMB5MG6+ARXhpRShKmCjjna
         1sBsi1xD7CndG74agIkhKOKYhHLpB+NKdAEx9H6txztO2J2QFL2YiURMcz96i8oLvqss
         10hw==
X-Gm-Message-State: ANoB5plkQi3pXyYaL4cR+6NP/RcoqERnR/3IU5YuX1WBgiEBmzpXCixm
        6NmWLTGirdkuF6jAGFLyI6jUjCIvBatsgJ6jSGQ=
X-Google-Smtp-Source: AA0mqf4mxipOIdgAQfC7ObsVkEx1/DrxCojHj1wEwONsWWhAPqnDQ+SxE1S+JKMMRMTakUKan2IUc+qVNy8buhAMUuU=
X-Received: by 2002:a67:c792:0:b0:3aa:9c4:a9a9 with SMTP id
 t18-20020a67c792000000b003aa09c4a9a9mr13993179vsk.75.1669474277199; Sat, 26
 Nov 2022 06:51:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:aa07:0:b0:310:4e:90f with HTTP; Sat, 26 Nov 2022
 06:51:16 -0800 (PST)
Reply-To: jamilaabass535@yahoo.com
From:   Jamila Abbas <msbowenkole222@gmail.com>
Date:   Sat, 26 Nov 2022 06:51:16 -0800
Message-ID: <CANdFxhVyQ=UsRDfpiM-HqHxzrSjR1uGcNZfwN_OsEN-Fi42RGA@mail.gmail.com>
Subject: Hi dear
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
Hi

I am a single honest woman, looking for a good honest man to spend
rest of my life together. write me here and i will send you some of my
photos and more detail about me so we meet possible soon. Have a good
day.

My number  +221767494956

jamila Abbas
