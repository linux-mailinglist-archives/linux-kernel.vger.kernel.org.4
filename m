Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF43470546C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjEPQ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjEPQ6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:58:00 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796147EFD
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:57:59 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ac770a99e2so153884701fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684256278; x=1686848278;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2k2TDvy3v9pwlHebS4Cok999Cy9agoYm7JK0L85MyA=;
        b=o4KWvg6ZydsZRSu1bdlJ486gjGTAR+Qc9Wnc7b286BVIwC/MjTplN6jR988tckqVIL
         X6XaoKHe3GB/Ob3VEAHiHYg/qSp2HdX5OAkwqeqwlSgjOo7E6ud9HlYnKq2iqtTKBD+g
         Lyyiq8qhgCSmOv6m1NbcWbZLYIztY02K/w2fTLvr4ylqGTWjo8c6FQLnzi62/EXVk1dF
         n0vEk27lht99VPBWAQV4nN2SWx6kMzAWxZnpAvklyGkAj9survJGsY0hULB+3dBpJvLg
         kaxmpdDC3J1wFscLHcv7idAy/LRV63Cu6Ahh6jqlpQMelMo7i9xaBH/OScUyd0IYfD9R
         bcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684256278; x=1686848278;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2k2TDvy3v9pwlHebS4Cok999Cy9agoYm7JK0L85MyA=;
        b=TVH3bpnD8F7fTWBuBHMZkF5QZnryYvy2lZusvl/xnK/82dz1BXh82h7sRzt95URD1S
         UQ38IXC7YBAwdIU6gjdy2wC4q6C4q1lLRIqZmF1bhr7uQVFV1I5vJlNlxIKlfvme9m7u
         Sy8CpHeBuu/bTVkONnZCSDQGHL1i2OJqJwawLklobhAUCJEF0vLBIWcp+JsYkzNPUF29
         poRAN7jYR3pOJWaP9jDx7iSnqygU9YWvUgrX04uZTi0uiivzLzELJX1eQQk+8o8Sgwv/
         rWfJ+4JRaSBKCWn5b+ggXEQKFwhLvDwkYO5wPic6vn7PxV9IR9W/afsfVvIT7QWsTIm8
         c/aw==
X-Gm-Message-State: AC+VfDwNH8U7O1W6+8ql/7qd+2DWVnfjKFfxtGJwD5rJoWycOFhd0j20
        e8IR2sd9UHHgsV3N9o4qfGptTlE4wg4mj5DoDLg=
X-Google-Smtp-Source: ACHHUZ5JhqxjqRmgYkrEXrcMkCkXqcLbwy78sQwKAtrDI4yrF1z/Ja+725ZdJZNTUPdweCpw24SiuUyYLTzpv5qrvLA=
X-Received: by 2002:a05:651c:212:b0:2ac:5636:c828 with SMTP id
 y18-20020a05651c021200b002ac5636c828mr9156412ljn.3.1684256277432; Tue, 16 May
 2023 09:57:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab2:63c1:0:b0:1c0:3f70:8e46 with HTTP; Tue, 16 May 2023
 09:57:56 -0700 (PDT)
Reply-To: alisontg7@gmail.com
From:   Alison Gilmore <wirekoarnold000@gmail.com>
Date:   Tue, 16 May 2023 16:57:56 +0000
Message-ID: <CAA_ENH5L2+Ky=dDBZMHO4uOOCmgpY5s8WExpwzdguNa_uaMayA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
 Hello did you receive the message i sent to you concerning your
relative funds before it get confiscated by the bank. get back to me
for more details.
Email;  ( alisontg7@gmail.com)
regards,
Esq. Allison
