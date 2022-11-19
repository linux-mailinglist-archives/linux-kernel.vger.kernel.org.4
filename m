Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC26630838
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiKSBEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbiKSBDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:03:48 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36A214D85D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:00:35 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso4045167otb.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hK8gQKj2Jl7lgqDcBBKtTJvHs8EABYLYSyaTEIcYmn8=;
        b=URHvo2QDLzmDVHf9T0nrl8cKal4WLoFSZ+mdmq3jWTl5gbRVxzLrruSg0y/9OduQT7
         tf2WDUT4JKbWF63rHkusstr+ox7q1LD84YYRCHM/5jhNnPlVI/QQTea8IF6484Yj5XWq
         HUclSszzFqPdJy7H+qbx5jUiIGNJwnQ410FKc9oB4NjZDdLa+eU30kWrWSVBeS+qGQTn
         u4rk5+cdq/xQDESAquB/7VbDqDtg0T6gEM1R7OcfZddn77l7lEXqYfXoyhEBFZAU7eSH
         1jwbQKOCJL5xNp9oFV4vgs6GsEonk5QHt2KjHxvLkqwIdHyVkNduse6zu4uRh08py6GO
         H8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hK8gQKj2Jl7lgqDcBBKtTJvHs8EABYLYSyaTEIcYmn8=;
        b=nMucy3yDKgh9zb71Z70ItOOEIxLklsXH3c1qpyED7Zl3k12GREFxFECjtFxrjcl75i
         K9k7GhPFc3isl5vzpNPmXnWFZ6gqxckcFzrCuc/oxRij7Dk3eS4dRilQveeeLpsSkCTs
         knSsgxxAccDdstoOcy5kEQnDCtcw1krUp84mrKXfBMelLQQYrirLWhkrDgvBfDkrPQb1
         gXqO/G1zVFWH0lcLHWPmv3nQ9SvU9hUxUFFblapV95UDqfirNGx34Cttg2XpxS7Of+v/
         ameuX7r5ftml2PepGyVPuJTVE6P8aG6J3EwRyyOX0UyWZv/keDw7Ijt5hqT9UntgHYGg
         hc7A==
X-Gm-Message-State: ANoB5pmlmD4ltZTfvKOAbSk9MgDauI2pYRl9f3nVMNa4+/OI7Vz4lfO/
        zEjntgUPj29aZPfTlzhKhUHo/5I09fN9ZNj7f/w=
X-Google-Smtp-Source: AA0mqf6BjgsEGde9c56cOJR/XBDKOdoUn9qlPsJCq+jVBnLmsKrZf7L1lKUoW60kyGcXmR1QjuGdTGizhpyFWvpzoFE=
X-Received: by 2002:a05:6830:1252:b0:660:d819:d08 with SMTP id
 s18-20020a056830125200b00660d8190d08mr5007218otp.192.1668816029122; Fri, 18
 Nov 2022 16:00:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:7f06:0:0:0:0:0 with HTTP; Fri, 18 Nov 2022 16:00:28
 -0800 (PST)
Reply-To: sgtkaylla202@gmail.com
From:   Kayla Manthey <kontajean@gmail.com>
Date:   Sat, 19 Nov 2022 00:00:28 +0000
Message-ID: <CAGJkU19++KPBU7=wDi-S-22j=Cuj7iMDL1WQTi3tA9HpJTn+6g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo lieverd, alsjeblieft, heb je mijn vorige bericht ontvangen, bedankt.
