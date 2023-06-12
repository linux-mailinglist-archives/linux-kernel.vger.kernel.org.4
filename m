Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A4F72BB20
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjFLIrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjFLIrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:47:22 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4843CF4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:47:21 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id af79cd13be357-760929a1783so19683585a.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686559640; x=1689151640;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkdVEcOL3MivfnPEt17VXfVr0HH+EzDWDNZdzgg2a7k=;
        b=JeY2EghuCge0wwONGUonqDRZdHe/VfEaHFCdWzPPsyEBbUxQ+lrumLknvj5IXDR1BU
         TntPj3wgyKdhAEVmcOlY7OysViAUSa62fXKA2DDcdfMKfjtBdXLRI16akwXchILR6hDu
         yMZ+P57OcGrQAj36PgPL7ROcZhzi4RGfFPtiWm0q8o1GLjpL7QONMZ92wPhmrNpSi7ae
         wA8BaDRUz4N/gAUHTvxPqrZe1Q74IU5i20tw6WZ2/35WQJIkvcKAF+ljyz4iJ4Si9fqV
         +/Ei+9Klxl0UkzFKQX4pgbT2a0S0YV4MWCW2hgA5+D3r04hytC+o9380s3edgV38KaEE
         AT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686559640; x=1689151640;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkdVEcOL3MivfnPEt17VXfVr0HH+EzDWDNZdzgg2a7k=;
        b=ZtxK65gZQLD5A6VEr406UGhGndcLrArWbs+E/HNC5zVXNqrncuih2we7p+WDbSRz9z
         ynC3KpLTuxljrNPhCJ3nyVb5iRCloRvkq66FiREmM1nBJU7pDYe9BgllDykLm/xJFBTH
         FBPCnb5H4uGci/aWVtlsoo+1wcELMYtuXA98C8n+slyZgTgUpfLIZkU8NEWKcM5ZvYRx
         nfyvbyrWAY7mhjn24gr6vt7/vMSujRqBRiIeOFFhOKjBVZXBUF36Fr9B4xJsSzspFYkq
         8GMuYUQl+3WsuLeYBpAy4dgbicASyQfmBRB8tU+RtO+lBrUBCULH4DGYjuW8rpfuxDv+
         PGBg==
X-Gm-Message-State: AC+VfDxpRVB7AozybkBKxR2tSSzeQhJhyedjYyWFIOaIDXajdQvtyBBY
        tFSs2rvNu4ZuXcwjDTheYT/5rEL113O5KfDIehA=
X-Google-Smtp-Source: ACHHUZ6FhwuLyK4ZWUhfVM/TwcDrIrk0OUS5v41+WR2oRKhvAlcCOa0W06VUn95Hi/d/MY6vJpu0BK4i8+9N3UVCe0Y=
X-Received: by 2002:a05:620a:6a09:b0:75f:3a3:c997 with SMTP id
 uc9-20020a05620a6a0900b0075f03a3c997mr7129692qkn.2.1686559640320; Mon, 12 Jun
 2023 01:47:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:25d3:b0:4d4:a69b:c8a3 with HTTP; Mon, 12 Jun 2023
 01:47:19 -0700 (PDT)
Reply-To: zongokatyh@gmail.com
From:   kathryn zongo <casimirekere11@gmail.com>
Date:   Mon, 12 Jun 2023 08:47:19 +0000
Message-ID: <CAM8GgLQMZwC8Y=ZqLNCKtCLpCqgirTi7LHJLTfLW11wm_gsgCg@mail.gmail.com>
Subject: FOR YOUR KIND CONSIDERATION!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:741 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [casimirekere11[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [casimirekere11[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear Nice to meet you, Am Miss kathryn zongo, very sorry for the
informal manner in which this letter is reaching you as it was
necessitated by my urgent need to get your response.
I came across your Email from my personal search and I decided to
contact you and I've something very important which I would like to
discuss with you and I would appreciate

 if you respond back to me through my email address as to tell you
more about me with my
photos, my private email as fellows (zongokatyh@gmail.com)

Thanks
Miss kathryn zongo
