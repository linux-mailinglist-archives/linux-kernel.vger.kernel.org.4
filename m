Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916E16E01C1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjDLWUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjDLWUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:20:16 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80014EDD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 15:20:14 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id cd20so2441549oib.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 15:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681338014; x=1683930014;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOqKQg1g9uhRZzTHxC0QzPUmUEVDocjviX4Ge/qp58o=;
        b=QX0HYpDkR2c8nawnQAV+cX4Zj2i01PhEWWu6kyfz959AoQD6+JjMhGl3NIKumsdjkk
         PeZ9hbVclYJQ7tQtkvYHXSu/IgmP5IaB8pr7GUl0H6ymPZX636I7Dlhx7fCE8oVLfCgc
         B8zwaiEx8mnRPsC3/X/ciNO6m/OkirgGtT7FmEy9tOgp0MGB66GY1/UZXwl8a2/uO6Ui
         eTGq0owSWeYi7jqkYbTFP+ILpVt3BYswNhKa08271zqKNGZ4YBRxLW+YgYBscclXpZgD
         s8gtI8h9ZMFpwtJGQzH9kIWVf5tJT/bYjYZnRmQbjHCUhjp931mRUagcKY21oa5bSTPd
         IlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681338014; x=1683930014;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOqKQg1g9uhRZzTHxC0QzPUmUEVDocjviX4Ge/qp58o=;
        b=kwo4bc1zANPPKMfCLzvNOuNxtDkotxyPtuY+Cktef0qK64lFcM7g5hc0mciMW0E0H0
         Oa2R8VQxaRBb15rEOAKukBaExhP5ziPuMV4Ii9Hw5BgtA5e1Utx/VJMOJ09aY7IlYbb5
         AEImyT/Ul0ZxvFky6gRT3t2sSYDoFmRD+DeNE2s7ZYeouKc5nkmEAXSb4e3uesoD2l1P
         lEGjl/ZDkp8oL3trnO4PrVYWAF5LwOfmiNd27NlnGPt9cZPs7ol/Z4xcDKLcc6yFi4Lt
         risNi+SpKGdJlBkjG9C3cK4wG0FCPLhchI4xBz1r6TPhSO8dCH6T9dGO+teVPrTHB4Wy
         gyTw==
X-Gm-Message-State: AAQBX9dNCqOhr+cFDz50l+MYvH3B80AhMPCKU3vvZUoFFAb1XKaKcS/1
        LAUwjdGRZ1XxtioBS8q4qhSzZ3ZV3oymF8CVgAk=
X-Google-Smtp-Source: AKy350afNAlW2pfcpPwHsgBQFpdHpgOLQ6LFFGasl1PiqwoWofP0XL52lPbSvSqte993T4Tq6wQTQ7mBGrYeNYlSC9c=
X-Received: by 2002:a05:6808:918:b0:386:e33f:84f2 with SMTP id
 w24-20020a056808091800b00386e33f84f2mr40501oih.1.1681338014124; Wed, 12 Apr
 2023 15:20:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:9198:b0:f6:a022:bd4a with HTTP; Wed, 12 Apr 2023
 15:20:13 -0700 (PDT)
Reply-To: elia010clark@yahoo.com
From:   "Mrs. Elizabeth Clark" <hodd2970@gmail.com>
Date:   Wed, 12 Apr 2023 23:20:13 +0100
Message-ID: <CAMGof+B+aVE1=1JnfWf3uTtarE8fJUbcuPA=OWs66Ue49znCDA@mail.gmail.com>
Subject: I look forward to hearing from you!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear,

I have investor that want to invest Two Billion USD into a company
that needs fund for expansion and also Companies that has been making
good profits but needs funds for EXPANSION. Me and you will be
entitled to 5% of any amount received by the Company from the
investor. I am Looking for a reliable Company that need funding and we
can easily make 5% of the amount but we need to maintain absolute
confidentiality in the transaction.

His Area of concentrations are Real Estate, Biotech, Textiles
,Information technology, Pharmaceuticals , Oil & Energy Industries,
Mining & Metals Industry, Management Consulting Industry ,Maritime
industry, Hospital & Health Care Industry, Consumer Services Industry,
International Trade and Development Industry ,Gambling & Casinos
Industry, Electrical/Electronic Manufacturing Industry etc.


I look forward to hearing from you.

Regards,

Mrs. Elizabeth Clark
