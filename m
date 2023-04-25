Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1CD6EE81B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjDYTQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjDYTQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:16:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3103C35
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:16:25 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94eee951c70so980012766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682450184; x=1685042184;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnKFL26C96VIgV6J+JP4Ljyq4pSmVr5ajTDLJ4C8iVQ=;
        b=AqwZ7OSMZLog3qGGpsBlXBUOiczpKZvSHve+rhm++l/798NXu2n0/2gufjv6jKoygI
         /zqG/eo1p9/Y+p38YQpEFzpWZW1iooCak7LQJlSv2O+F2N2UjDX1gatwDtUjwlBhfefE
         g2Fg/CjDjjgcsetvCM48P6k0xLyiQ8DZ0nB83GzcvsAFRY3VIWH2/rFkopWUKJfy7Iha
         xViIUEGSTeCs3mNd7497EihLNZsx94gkFmb6vIlI83aeoRbLO1Wc5Z8sbVmSgBRvqujV
         FnKeBmv0mtRnHlpsCpR24p0SEUTloEGz8EDymoEGhHUkJ8C2my/6629OkE/EJi+TBMQh
         cIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682450184; x=1685042184;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnKFL26C96VIgV6J+JP4Ljyq4pSmVr5ajTDLJ4C8iVQ=;
        b=PDKaQaxX8b5fRDwC4PZHbaRFBX46yrLhzQE/Ppc9xF5ImzHh/IeNcp7Ljzyns/tR8e
         1mkCgm2eQCDqR4EIxUq5Wn5kqg2LwIE28283ct4eT67bdzt5ibGZIy03JfvFvu9dN6AK
         JWID7kxU8LcE7obbBqEMw0abuPaoje/hpb6W2mI489ONcau/KsVHdEzNK1/+Bn25zka5
         NNK98yCYCzf5tXcC6vX/rocSPQ542LB+Macjwbwrc4y+5ElV1fCKKl6opdNqkoZWKljG
         8PoFRKczYiQEUWKlRNbEF4dYNHYJmpmcmGH1rRcDQ2iUpjt6AOanjDeD7h/gFmqmXkmp
         V3bw==
X-Gm-Message-State: AAQBX9eK5VbvUsAY6ijjkDwDH2AG64vg7JdEbxKxiJqv+QWc13CKMTSp
        GeHKQ2PSH1179t2VCnmeDolmeonQWb7Jsdeujl0=
X-Google-Smtp-Source: AKy350Y5V5U+kqSEmeE4/wcbrt9LiSgJFXXGjEwbpiOzCLlizN+d4W6KaK9f7qD65Me7MKA9+Vc67cPGONiCs0B4byI=
X-Received: by 2002:a17:906:34c8:b0:94f:2249:61d4 with SMTP id
 h8-20020a17090634c800b0094f224961d4mr14704304ejb.34.1682450183864; Tue, 25
 Apr 2023 12:16:23 -0700 (PDT)
MIME-Version: 1.0
Sender: munniralhassanmunniralhassan@gmail.com
Received: by 2002:a05:7208:c04f:b0:68:3a3f:3968 with HTTP; Tue, 25 Apr 2023
 12:16:23 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher001@gmail.com>
Date:   Tue, 25 Apr 2023 13:16:23 -0600
X-Google-Sender-Auth: cG4zKUgZzxjjHbGgrZF6EKMT0p4
Message-ID: <CALefQgPp1drfWu-ELiojkJJGwRbtbtaMj8W+r4s23KLFk1nOtw@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_NAME_FM_MR_MRS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply me.

 Hope to hear from you

Regard
