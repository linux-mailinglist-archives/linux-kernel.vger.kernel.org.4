Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351B6656CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiL0P7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 10:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiL0P7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 10:59:44 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A34FB4A7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 07:59:43 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id g13so20133200lfv.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 07:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHGMhLCsDJx0tsoT7d5T4ZB5hT6uZc8Jnfvqv5jhDRs=;
        b=pqB46t+KoPnwQjaaA+a9nvcxi9XBUFRBnwnc5xLPSlvQVI+Lor3oi66XG/FnbiLyrI
         +k0bXNuJp/cz/t+U6Qad2E9vwNjWucnUZa39NxgBPDDjgjf4lpact2FkAxIH8J+LH+qx
         QqQKsZJvIireMnasBfqAaljUcdytEB0ZWrySxGMxS/yGt2hb5nOSJQogvnI0+VdIQ3M9
         X9GQ2mS1s1CdBD/5nnbnoZeqr+2LxqA8qs7FnvC36JlnQ/7xPyAfwGnSTQlNuGsYr1Bc
         6Dp8E3P7sA/JEqO5SxjhNLcrV4G+RFVx2VQMt+iKfBwkj0xdzgshmULeAgyvn78ge5sK
         djBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHGMhLCsDJx0tsoT7d5T4ZB5hT6uZc8Jnfvqv5jhDRs=;
        b=bbNFwhWWDpz7FJqV85RYlEpA6QcxUXtKrZ2/Mhhx2kvc9NbzoHaHgfm6IvgOOSERbk
         ryZpMo6wHf2BikuJIHng746GII+zuraafbgDjidp7OZ5OJ90Y4nOf3yMgLJMlIlxebgo
         KgybVYBDh3ZYnvoJlKtW0UshES9e2pW3OVz5ICT7LmNb5mkpnQfOcgcA0shZ32CQ0iVk
         k3dim6vEwWqHfG79uBu55iUehMifqCS1dqF+t0vEVqKyCdBuioWLeNKK/Hcg+fgxIUoi
         zO1vYqUnhxDjlJ/iWs6GGaxGkC6CUawQqSlZQjAMUi5SLMhoZ3PWn4NMdHgXikbnWQaw
         UcEA==
X-Gm-Message-State: AFqh2kqH1RgSvG06bSD7446ilztGvxE08jcOmIpju/kADADNdAZn9OiA
        hf289Vn+9cfIDXcGTswTYapBdNq/vwX8iPh1KnU=
X-Google-Smtp-Source: AMrXdXtfH5GegzrvlwLW1CGa6QhgHH0qqAuKyoZVHBogM1i/9EmCWK8jnj6HP8mViwNZqnraCVa9DJwC8oLgyLWrkhs=
X-Received: by 2002:a05:6512:3e10:b0:4b5:6ffd:2cba with SMTP id
 i16-20020a0565123e1000b004b56ffd2cbamr928364lfv.360.1672156781455; Tue, 27
 Dec 2022 07:59:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:aa6:cad1:0:b0:23b:96f1:3778 with HTTP; Tue, 27 Dec 2022
 07:59:40 -0800 (PST)
Reply-To: rhsheikhalhamed@gmail.com
From:   Abu Dhabi Investment Authority <directefinance@gmail.com>
Date:   Tue, 27 Dec 2022 16:59:40 +0100
Message-ID: <CAHS1Y9TEixyHcB6wbUL2dNZoq9NtHa3p5UKDqdEpR4fSiKZ77g@mail.gmail.com>
Subject: Salam Alaikum /ADIA LOAN OFFER
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Salam Alaikum,

We are a United Arab Emirates based investment company known as Abu
Dhabi Investment Authority working on expanding its portfolio globally
and financing projects.

We would be happy to partner with you if you have any viable project
we can finance by making investment in form of a debt financing.

I am the personal advisor to Sheikh Hamed Bin Zayed Al Nehayan.Contact
us today for more information on Email: rhsheikhalhamed@gmail.com


Yours truly,
Hamed Mohammad
(Personal Assistant)
Abu Dhabi Investment Authority
211 Corniche, PO Box 3600
Abu Dhabi,United Arab Emirates
