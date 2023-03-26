Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB2F6C93DF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 13:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjCZLEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 07:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZLEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 07:04:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E2D8A7A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 04:04:18 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j13so5256884pjd.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 04:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679828657;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLA5i81PXZUm56suBeIwZHhuE8ug109yJCU2CiElHKQ=;
        b=B0i9BVonjMhR52jmfQh37/CABanvSw1yBZIqsSf793ujbZJRkleUZKykYj5Gc4cAfL
         dGguPk6LU5wGAEx9PX7wyxX7/xBLqikw98KD1p3j+XdfZFeSnr5fjv/2Ef7cXfIjvppX
         hdJQB0TJ4JEBmV4NhVKEM3XQHf9/mYtJdtK5yH42S69iAge3HEZWDlBYfsxnetcAZ+f/
         7x5NsAu5wLXapeFcOvNdTIlkQR6N/QNeUVv3zakHNKVAvwYrPY9Ew2sgT+1jhd9PiQPJ
         HOd3bdmTOYpX3tz2pDS0vZF02ofliipvXFm5fHPickfnxmYND/4WmpD1MXqetKkdWwbE
         XuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679828657;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GLA5i81PXZUm56suBeIwZHhuE8ug109yJCU2CiElHKQ=;
        b=R+G3DTVawXS1BgDK19T1IDLNbEp9lItnfD4ykb6taK7hHcRnXeGNHE4fJ9mhrm5qMf
         rV5swrvfdSmhGBwV+1U9PXovZFjMNOVop2mKLolprwNOa5ZU8nXBoX+lmd3VatOv2b5X
         Q711V3W3MZqpvYPUjO2OljKzTLuUzT9PC+j0QnOIkBMZIP6cHFIuvHTNPrT8A7zLl4mY
         0ZkI6Jy3EuGwB8GzQYVkqaZpBjdKi08WhE6AGIE0eGuCxpypo34vHOnbSkBXKv0TEDD1
         TjEbmelKg/LjY/Y3oLPKTx6PCbpdN/NDu/2KeexUzeLdgqOeCwZh7oN885GknsBMIZh8
         PnOw==
X-Gm-Message-State: AAQBX9eFtVhCxvt+25mPRZjBy2F9zpOQ6TfZ/3GLqFJEpy5h1z8GaTNw
        SZJacizx7EEa7N+AngKF3AUIKV1rEnMDFoKrke4=
X-Google-Smtp-Source: AKy350Z+KEhnQ2Y5Cra2tmkt6VAANrPBTBp3i41sv1WP9txZfmCIaKvkEvw5OLEsldwWArucFO8EJi+v2sU+TM7YNMA=
X-Received: by 2002:a17:90a:3ec2:b0:23f:4b8d:2393 with SMTP id
 k60-20020a17090a3ec200b0023f4b8d2393mr2386925pjc.8.1679828657428; Sun, 26 Mar
 2023 04:04:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:d60a:b0:415:e6a1:1118 with HTTP; Sun, 26 Mar 2023
 04:04:16 -0700 (PDT)
Reply-To: samuelkelliner@gmail.com
From:   Samuel <hussein.alsayesauto.mynaghi@gmail.com>
Date:   Sun, 26 Mar 2023 12:04:16 +0100
Message-ID: <CAGAM57xRmb=OE-QxGD=miQOZJ0iGcMdwu83D+PJWiVbjzoevQQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I am aware that the Internet has become very unsafe, but
considering the situation I have no option than to seek for foreign
partnership through this medium.I will not disclose my Identity until
I am fully convinced you are the right person for this business deal.
I have access to very vital information that can be used to move a
huge amount of money to a secured account outside United Kingdom. Full
details/modalities will be disclosed on your expression of Interest to
partner with me. I am open for negotiation importantly the funds to be
transferred have nothing to do with drugs, terrorism or Money
laundering.
Thanks for your anticipated corporation.
Regards,
Samuel.
