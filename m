Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13661690AC7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjBINqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBINqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:46:11 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CDF1BFD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:46:10 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id jg8so6472461ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etDsOsklTFhdv20/ihPgdxxbpxkX/HMYSlW+AO+gqjs=;
        b=a2RTZMdnIeibIzSRdaFVkHzsQd+kfS1UnZ9tja34CLdN28yU0hC7avLyLChD5Hf2ip
         1eTeBqakCl+vI90Jdv4HKD8PT3Xb5PtOQ/Q7qMxJkcM04OuLPedshkuoL7xCAG0jYR7z
         0Pvhuh/A7IOc0lDIThjC8mC4tSca7XywcsFF87rXGxA3zwKbLpzevfvnfGGz9/DhfqBA
         t6IVze4/l6hio/RDk20qjvB9mO66LRSs3VylCRmIE3ddkwmzcGuIQ5dDxRKB3DIy2f4U
         SQuTwUNXtQForS79Rhd16hwkYm4yd3CBAKAeNoiaG3rYVDZfHp9glzi7DS17FgAtpzKW
         a93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=etDsOsklTFhdv20/ihPgdxxbpxkX/HMYSlW+AO+gqjs=;
        b=b5jiSgnwxOVWElO5oi7kTYXOd1F3/mLBprKmw3YVlUq2cYSryBUBRVltsnLeZjxNAh
         Cqr+JWnu+k5B4Pv3CKlWtMakjLZeX+YeL3Dx0BNJ4BU+4zteHDlwed49DEz9/hAmkR37
         hUapwfdSNMpQHFkYIz2iTKIv9NdCoqHtkbba3jpRp5pV010nhB/E4Gq4jy6NiqI0pGpn
         qWg5yoH/93JridDy5s22GP4DGqRYtcBMh+WIgMwHvL77pocQab9F3kOBCTGRdfUJPZ3w
         wmLBkyXmdOlrSwxb59XzZP595PPkLG5pZRCwi3pY6qHr/dp4AKD8zvMv+op+naiZUiwB
         xqkw==
X-Gm-Message-State: AO0yUKVeBF1Vn2HjRfbFpVxGD0quTUaf3FnpWFuuaZAMQ9nIW2ENIi6Z
        yTGF2sSRbwb3TCmOOx2C/+VBfg2yPAA+vmxYoI8=
X-Google-Smtp-Source: AK7set8kfJzMs2PPGI260iNETyvtyRcBb7JWXuZBy1iXkpVSfyF599yKv3/FTV22rp9aQn8hnJ7R62UpV5VLwGxwZuA=
X-Received: by 2002:a17:906:6943:b0:8a4:7ad4:dd2 with SMTP id
 c3-20020a170906694300b008a47ad40dd2mr2548930ejs.216.1675950369538; Thu, 09
 Feb 2023 05:46:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7208:aa:b0:63:7cf8:6a01 with HTTP; Thu, 9 Feb 2023
 05:46:09 -0800 (PST)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <arafaeloxford@gmail.com>
Date:   Thu, 9 Feb 2023 05:46:09 -0800
Message-ID: <CAM=40BL3LENuTkfDRPvu6_EZ5rktpHhe2AJqzCF6Wq=wT1U9bA@mail.gmail.com>
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
Hello did you see my message i send to you?
