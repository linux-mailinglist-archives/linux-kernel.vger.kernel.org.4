Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BA273B91C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjFWNuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjFWNuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:50:10 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCB226B0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:49:48 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 2adb3069b0e04-4f96da99965so812693e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687528186; x=1690120186;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WK6OLngTEGMQZnXAmgyK8gksEaTtYBKX+MRhgq0dtFw=;
        b=RGIW+3/gAvkFqeiCF+sPOiwkJmDVX3PeTa/NbcDgDYzw4xceVv0oe4WffGcA+LFbWK
         KMCMVx+DhFs2SiooydKL9t42YGDw+XhNBzO3n9yhALqcZ+yOCtMNn5f0UUpgRZ2Y3DJd
         yYQ2rAcZDMjI0JmLv5v1jYb3A2DOQiAyZFTV/TQnOWDna+C+uzBwUug2NQo0yU5LPesC
         ADJNoct/fkx3TM0Y02wakjYkRNo7Ynd67U4pF7NUCshBi3BgIsgUUYAfSmeVOQyXNFyZ
         nh0QUi/BOeBpP7LLEiAAvlDEWI+9wmolJLlJDuaodVH8wMirPtrPgOw3dNC8xsitsYUE
         LaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687528186; x=1690120186;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WK6OLngTEGMQZnXAmgyK8gksEaTtYBKX+MRhgq0dtFw=;
        b=YPbNAuVC46rPQqhUhgmbZF+EOv9qKyY5x9CPvRD9sP108xba2qyNm+wCINyLWlNSvV
         4g1Bf5af9kiQFnAV+6bi0mcwf8TYp4NyaMkjBsB94caQfJY1SHk1ljpXtAYRG5qxpiER
         k5F6Abel00X7nkxRG3kd/zf/Bn+HtyNm3nCKkXoDIlIFU7G0EXhUwK4E4riOP9yS3cGV
         fOip5SGnFDP/bVt4g9gNxe4FGDn35vrcvlpQiO1DmM6VkxbL0Ei5QDHyyvBJsFJZC7U9
         SWXC/zAFXw52wZi3YkdL3zlfpdb0ynmcgk1dtiP0PVlivOOGI8WxzuO+5Y/A5Q8jdGS8
         IyvQ==
X-Gm-Message-State: AC+VfDwA5qgUC2bMMkVoaPzp2r+r9b+n1+8U8aXFkv0MhMeIyv2QNkM1
        O3SQs2slnUWI5LrEQIvHBsmQOjri+UbprfaQbEU=
X-Google-Smtp-Source: ACHHUZ4UaxP+GTVyYg8+xaPmcyAEuBlr4elCffRLlj5RYQXRPv9DiTfSFWFO6EgogBHMoP3sVNuwOnndu7IlXuoF0fw=
X-Received: by 2002:a19:790e:0:b0:4f8:6e16:fca3 with SMTP id
 u14-20020a19790e000000b004f86e16fca3mr9924135lfc.28.1687528186368; Fri, 23
 Jun 2023 06:49:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:161a:0:b0:236:b3b:43a5 with HTTP; Fri, 23 Jun 2023
 06:49:45 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   sgt kayla manthey <tchaloelise@gmail.com>
Date:   Fri, 23 Jun 2023 06:49:45 -0700
Message-ID: <CAObQroXr0pF1VBNrdE7V0rOPc+8CSsdRX4Y-vWyLrKs2n4rGWg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Greetings,
Please did you receive my previous message? Write me back
