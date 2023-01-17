Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C4766E8AC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjAQVms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjAQVj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:39:27 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E7E10EE
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:06:04 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id i28so3059725qkl.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qdhWC+mZkHUdmYtIEDejSN8DW5n896XxUL824F8ocmw=;
        b=ds7KCsExZ/LGQIhY7yh5UxGzmFzcdD5dExyuDTBrB9LhPgt9mqvonw+9PcL3JLFRH5
         E3qVn5mIKnVKIMDCVFD38VCZrkjBM9HK44Bcyo/iLlaYOm+QUJaI7BN2RQewoz8DKALZ
         QGgj705ozH/0v+JSNFWyFP1/od4y726V9S+ELWArR7WnU+gp8BFd5vhaBY8oSfPYnPv0
         dJ0KSixhVIluUC3lgNMCN3gKzWOFwHHwIKT3pT44SDOCnCCjamAkXq2hUJrRsH4dXmRY
         kof6JdGo/b0L+/6gzpGjHnwfntVgUw8MniwVEQPrS68JAcKjQa7R4sqt2Jzp7PJdZPO+
         Oh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qdhWC+mZkHUdmYtIEDejSN8DW5n896XxUL824F8ocmw=;
        b=twjn5IPFTiTCGu1qR/rUjdoFXRXGknV4S7GXvKX9IuI8VsiuQy/X7Doigr/3TNr+Ri
         fbp52qbdFZzag31vGD9trtJFUQJ0em9EWaG/zFNQ3itJPq4E0tddjKco9vetM+MMsiSq
         gfMMwdWcc8kuaq/lTXbDqFnEiYFDy2aneqqXk+Q4a8puWucuC6AvIuV51BRbmJ/ZxidX
         P58roj1e1NNgEc6+ixX6lv6j6En6QwR9RDiPfgtyyjNFrYXOvGvaauM254MjQW6Hyktw
         EohTqwj0J0H4c0zZcVwyZHzvmoMQdgEXeJLnLjKdmqA7SfPCVS77ERG6jpbmxqqUp8gy
         l9/g==
X-Gm-Message-State: AFqh2kppHCwFIjQ3Gvfckm42hWVrT3DzS0te0PDwmd8Dut60XU9zKRN1
        49QJBHu22i/Gskmjf14qNSUVYgeHOJjgLh0rc3JDh9F/dZFCy7OJ
X-Google-Smtp-Source: AMrXdXtFLTKv7+C1OkFm+qwOvcHwSUVmVld8tluwkfr8Gwx1Tf3AuZbgX9/zFjbf9xPa5ylC5fKQtafeA7puycbsbGc=
X-Received: by 2002:a05:620a:b15:b0:706:16ea:101d with SMTP id
 t21-20020a05620a0b1500b0070616ea101dmr234555qkg.105.1673985962839; Tue, 17
 Jan 2023 12:06:02 -0800 (PST)
MIME-Version: 1.0
References: <20230113154253.92480-1-pasha.tatashin@soleen.com>
 <0c706897-b2cc-714c-c72e-4154b1f3f52b@suse.cz> <916aedc8-1d0b-a0f9-5ddf-6c6305e7cbdb@redhat.com>
In-Reply-To: <916aedc8-1d0b-a0f9-5ddf-6c6305e7cbdb@redhat.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 17 Jan 2023 15:05:27 -0500
Message-ID: <CA+CK2bCkjainoT4f=N3bDE-q0GhjmiJh0QMO42_m7oSYbV1xkQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm/page_ext: Do not allocate space for page_ext->flags
 if not needed
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        mhocko@suse.com, quic_charante@quicinc.com, lizhe.67@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> >
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> >
> > Mike's comments look reasonable to me.
>
> Seconded
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thank you Vlastimil and David.

Pasha

>
> --
> Thanks,
>
> David / dhildenb
>
