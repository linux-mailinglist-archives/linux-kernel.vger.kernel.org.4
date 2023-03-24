Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E5F6C7CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjCXKcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjCXKcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:32:22 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE77828221
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:32:12 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so1146397pjl.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infob2bdata-com.20210112.gappssmtp.com; s=20210112; t=1679653932;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JZZlnKmbmBD1jDe56IEbjyrsVjOvBUMRvr7A3bLP7AY=;
        b=ZSdicG3tfpGCjXQy0NX41pciRNsZ6jQJ3nxJ+p5YGMRvd0wNQPHgrv07otOqjRWAtK
         gQXkVnO2PM92o9LWDqseVNoBZ404MKos8+A+lUyqjV3Us7krlBk1OksUU01Nb7MnWbPc
         y7IZzZ5LjZFPuBwykPiIPShIhQ5nowKKAMgVvZ/nQn4AgQIA41gYtSbPs7I60Voygj3E
         ZeX7FeeOU25gpOhgb5aaem0ckqQdmEodoKdgPP+Y5PKcNYLkelF/VlkVc+pBxFSYrEKp
         412aqNJ4d1ihjFt+QDj9fxm76ADNZR1ib7bTYnGYgVF/oBNf+943tWUjBtA+JCcExs0/
         z+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679653932;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZZlnKmbmBD1jDe56IEbjyrsVjOvBUMRvr7A3bLP7AY=;
        b=RvZ2V/CBmkar4WJjsJNRP28ZRNL9HJRthAagMsGn7MgucguotdWE/fRyl/o9qy8hP5
         dPsNKB0aq820pj1pWG91MxVypqS2uWUg44BlhwV72rf5AnHHNnyY+z2521Cfib1tG134
         UgSHt4Xs3OvcBp2LdpmNwzhdMpKAiIfAGyLvjdgBeMPxgOJlnmwwRFtwHaSMI0kzQtae
         +vlplzTvCWMsPrr79kWf2KvlWKdVvMK33GPfr6kLU7kU91PML+4+nJaJqvE93BqoA5Dp
         1J4B457AfkyqfrTvpGNYdrN7RgJqbyDF28ZIDUF9TvFMUxdzc27NWpYukIjgfrJ3TqWV
         zjYQ==
X-Gm-Message-State: AAQBX9e2HHiVmrN5bxpwm+hHYx4P5iUjrGP+oOTaGWBXD+OsWEn/SPrb
        fkhS5BFoFCpIfOYVplNt5RFozlXpk1u/5OVxyoUR2A==
X-Google-Smtp-Source: AKy350ZQcjae49tCy6oNT4305N+Z4S8+Y7ujTXsVfhIJKWegMcKISgvj8/M2PyjvwLANblxKgtuXyYV3MUZVo7I3qms=
X-Received: by 2002:a17:902:dace:b0:1a0:41ea:b9ba with SMTP id
 q14-20020a170902dace00b001a041eab9bamr768901plx.8.1679653932429; Fri, 24 Mar
 2023 03:32:12 -0700 (PDT)
MIME-Version: 1.0
From:   Stella Jacob <stella@infob2bdata.com>
Date:   Fri, 24 Mar 2023 05:32:00 -0500
Message-ID: <CADH7MrHv=1LpOVzS+BemAgGSJY3EtGZq2YnydQHjLXO9agr9=A@mail.gmail.com>
Subject: RE: Fintech Meetup Attendees Email List- 2023
To:     Stella Jacob <stella@infob2bdata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hope you=E2=80=99re having a great week!

Would you be interested in acquiring Fintech Meetup Attendees Email List 20=
23?

List Includes:- Org-Name, First Name, Last Name, Contact Job Title,
Verified Email Address, Website URL, Mailing Address, Phone Number,
Fax Number, Industry and many more=E2=80=A6

Number of Contacts :- 6,386 Verified Contacts.
Cost : $1,489

Kind Regards,
Stella Jacob
Marketing Coordinator
