Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0263E608BAD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiJVKdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiJVKc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:32:56 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42F0101FE
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 02:49:24 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id y72so5896351oia.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 02:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VaaSLAJ+hgNGNq49WyPsh3ndDLo+mnrYcswrOHpJSv8=;
        b=nNMBkCIwl/6gK+toGqNRGG/YLL0fF324bx1qaOH1y4x3OIjxLq/HHYoLEQ6DIXVMhZ
         yBP/JqjfeKgn2zVw2pvLxCg6MQgOccj9D0PS+BxibSDKUMZPqFuO1BH9rucwVtk0imfk
         Uf1JB6y6hh5nwSF4l3nIHzMcJeO23qzW5xyKvOUo02NXv/UxA+fb1xfQ7gd0wj97+Png
         rtJzhayXE1f7/T0HHp6tTaPH4f4DE9rtLLXyoMLmdIeuEqEwHYp6KAIXioE2APt9Vqok
         QcnzNnKCtevhk7rrd2+8KLFUz2JMtjuKTuyIwbz60pUc4RihSWynNyvtYnVRFpjOFC8v
         n2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VaaSLAJ+hgNGNq49WyPsh3ndDLo+mnrYcswrOHpJSv8=;
        b=euKiqKETJUzJ4uBBqFoVS6m/dyPDZzLJavJTYRRdCVr+gM/dCbw8SxM9hjlCGTRlEI
         PfLz2Y869KmlB37etbl5fvliX4Rte/az+v6Qfyz9frCxVec4xgJUx7rRqvurSjXQhn5Y
         n4uNIKQo69kzA9jSoCkfTibIpyV8TNS+m/AphRNjtXTP198VE7Hs2KVPr8KC/xosSrtR
         u5wkFSdEet3mbPGWWZXfhoe7F/ElD6YlYrIsAlNN5xFDhKP+fmu1gdFSF/44EyOr8Zew
         iEd0+7yO8j0Az4wZLUK7qk4zgAovPlI2W2EBi3niA9x5dtXi+utyWY6IJNNbzjfTO1/k
         Hd2w==
X-Gm-Message-State: ACrzQf3nBfUNxZR++PlKPOhYUs8qQYeduVE/b9CF+5dKzAf/qBY50WvU
        QHUId2sPZjUF54q/2b3NhtpD53WfRxvgJqM5Ny2K8gdlB0U=
X-Google-Smtp-Source: AMsMyM7DV/UQjMDmfWUDARQEST583xXUpUhZuwI6Yo6QWpU1NylqbjJLzURvxWrib8B1x1GiMXZKxXX9K7ug1XjFr6Y=
X-Received: by 2002:a05:6808:13d2:b0:355:1770:c6ef with SMTP id
 d18-20020a05680813d200b003551770c6efmr21666671oiw.284.1666427448022; Sat, 22
 Oct 2022 01:30:48 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrs.susanelwoodhara17@gmail.com
Sender: mrs.arawayann01@gmail.com
Received: by 2002:a05:6838:aea5:0:0:0:0 with HTTP; Sat, 22 Oct 2022 01:30:47
 -0700 (PDT)
From:   Mrs Susan Elwood Hara <mrs.susanelwoodhara17@gmail.com>
Date:   Sat, 22 Oct 2022 08:30:47 +0000
X-Google-Sender-Auth: UfMdHY-IGn2vy7vhRxwr3_PMsYw
Message-ID: <CAAOf0OErkdBB+pkMfQKO+67_RwCPJjBUpQs9uCH=U1CN1QD5=w@mail.gmail.com>
Subject: GOD BLESS YOU AS YOU REPLY URGENTLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_HK_NAME_FM_MR_MRS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GOD BLESS YOU AS YOU REPLY URGENTLY

 Hello Dear,
Greetings, I am contacting you regarding an important information i
have for you please reply to confirm your email address and for more
details Thanks
Regards
Mrs Susan Elwood Hara.
