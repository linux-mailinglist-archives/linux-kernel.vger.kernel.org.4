Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8486B6169
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 23:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCKWPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 17:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCKWPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 17:15:03 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6729C4DE08
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 14:15:02 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-536be69eadfso170722457b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 14:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678572901;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEf+AExShPx1OxizK74Vck7+V+R0v3E0oj9U3JcETH0=;
        b=hQ007Qi05jzSB4LKYcC5TqSqkWoh+kvnNsR4k4P3CTFT96lSx3YWXmgviAkHmpb+Fk
         24+KAHaHYVSZ9+JBPQAz0/0xPG4OMPb8PhchAS7iGyegNO7NraeAqT5fnSpc/87wRjpd
         GfxAzBZXpZypG/Veck+w78fETGR6RWSdXCzJs75WtAxnb2XsrNLG6kiRDMOVbURFAbdD
         kJkqYJIQz0f6pKY0u7hLhy/lRHKHMo7sCzR37z9OytmlFYUH6cwWSj3rZlhaFaP+X6+G
         Q4lsO1C4bl8BkwJu51wXMtzo7BrKb0GOBvafOQlg31WUMy/16oQA3xCu4BW5SJSRgGnX
         Dciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678572901;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEf+AExShPx1OxizK74Vck7+V+R0v3E0oj9U3JcETH0=;
        b=W6s2DiU3tbUqyb4qO8SeYXhhqo+TF6DTG2dedwZWK87t6d0gfjcxjIJS36EpkTygEN
         sijxN/2EtpFXIA/O8J0+5/YOtCb3M1ySdz1V47OFMw6uDN/VCg7FXnAZokcTAY6mziQm
         eTNdbKt+wno5PDUWRStLWUG72J9doms4CT6W5gke+xVtWtXZOQgWYy86QlAUIHfCCsso
         CI22y0w24y3mPgn3FSOfSYQo1VvUK/7JSjh3lWwndN7opao1A49ecquoG+k95vC5Wkqs
         buhUgMKDX9OAckZkiKJdHX27uyHkfonMzNQSPf0tCsxGhIuGgyQjeTjRLDj4Xv8WnH4R
         MR4w==
X-Gm-Message-State: AO0yUKW2QkY8k0znYiphYmMrYmrIvCW+SUXlq74a+EoxkjOO4gpYbrob
        2jXMSC29nTxltBOBgU42sRuV/wR87OhxKSX33Dk=
X-Google-Smtp-Source: AK7set+fH3fnYhNF/htKP4HjT93oYN0rrRygKtkMgZbhUhXWl1HDlf+qteIhKJJ+w/jtWfWge+9hgqToUmDB2va/KHk=
X-Received: by 2002:a81:a906:0:b0:52e:d2a7:1ba1 with SMTP id
 g6-20020a81a906000000b0052ed2a71ba1mr19518347ywh.1.1678572901627; Sat, 11 Mar
 2023 14:15:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:419:b0:1d0:5a4e:a083 with HTTP; Sat, 11 Mar 2023
 14:15:01 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <nambiemagrang@gmail.com>
Date:   Sat, 11 Mar 2023 22:15:01 +0000
Message-ID: <CACrRiTEnUUdM53pcmzgfSX75=bLe5jeQFg+1kUWO=zW7BxA0Vg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear Friend,

How are you today? I have an important message for you just reply to
me and I will send you more details.

Regards
Mr Thaj Xoa
