Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330E667C4A1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 08:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjAZHF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 02:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjAZHFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 02:05:52 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAE25EF8A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 23:05:51 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id v3so525206pgh.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 23:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56U3L/n2SWLavdhRRg0Yc0+2596Qz1l4ZkRdkLejoUU=;
        b=Mct5yit2rsuY2a7OwjpJ0Iqt6qh7Ti0Y9nXjwxZEt8GhKkrRdj3wwqgEs/ehw3nCcZ
         2SbyzW3HpgMcL83cW1dsSSZzXCU8XK/qxJoozFTM6e52Yof4mlZ8/eE9xokgTIVmhHFt
         tpeFhLi4zJn9Sgqjw9VJRxPDxdgN+yrNcer1RqJQocoQE6I1qY9q3vPvT+omvfJPsiNj
         xqnwcMm0bvbW0zlG4yjJR5sps2gw9he3Zlq7mFfHXGgLrEUJf7ZPTA9B8iL3WaB//doH
         2WKcHUdrtYsTNhZA6ZZN6EJVonBMsab36ydLM+3jiA2QUwrJZxpxF6xrS2Ne9jAVk6oa
         bXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56U3L/n2SWLavdhRRg0Yc0+2596Qz1l4ZkRdkLejoUU=;
        b=0OMZH429MfP4EbfYoP/8cdhyq6HIJaBGvKLvpuAA90vgjL4RAZoONiR0TWi7fmyNzB
         ZBoMOOR0CStzvTrxeTjfBG5rKl+UpiaU6owga0TYRKZYkPrcuwtiot+z62fBKbdumGn9
         tLBtaeJg8/0J68kptcQjR53D0X6wZ3TWF162+r1duxR/vHMr1Y9/gOOTcVIVcKHQAEnn
         HEPAcZA6T+ycqRjrzCB9gAsYMnKOaHguNuZhgmCfPRQZwCbaJ+Ms4LIiO3nHFVS4Hz0n
         l5GEMHw4oxCo1K6HHQd15KylyhlB2/n/iDdgv8yNCSnz2YCHWW8Cs/e6l9ZWJoMXwubk
         xx4A==
X-Gm-Message-State: AFqh2kq/FQ3XeW2prztME1NWccCAKcIJvrHa8/1v41PkeZHma/tClb+i
        qkgWJilyfcX+lXJxaXsVPc92DNksPsVwr5VFcA0=
X-Google-Smtp-Source: AMrXdXuY19vyiumLXQfX1UZXS3goHHkkqWy/eM8yJqkg7Ci3zUgzMDefgmEsvyvmjiPPe8pt+DzDS1W4mEZeSUAA2VE=
X-Received: by 2002:a62:e80a:0:b0:58d:982a:f1ea with SMTP id
 c10-20020a62e80a000000b0058d982af1eamr3325406pfi.28.1674716750663; Wed, 25
 Jan 2023 23:05:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a11:2004:b0:3fd:105e:1826 with HTTP; Wed, 25 Jan 2023
 23:05:49 -0800 (PST)
Reply-To: westernuniont27@gmail.com
From:   Western Union Togo <kinvie64@gmail.com>
Date:   Thu, 26 Jan 2023 07:05:49 +0000
Message-ID: <CADvytFM-wgMVeRyhNT41nH_D-WBkVLgtwe1X2m=McSdVE1xwhA@mail.gmail.com>
Subject: 
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

Your overdue fund payment has been approved for payment via Western Union
Money Transfer. Get back to us now for your payment. Note, your Transaction
Code is: TG104110KY.
