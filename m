Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C75F5FBDAA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJKWJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJKWI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:08:59 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779D6631F4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:08:57 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id u71so6436656pgd.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YtqT5AIkDrwt3Z27J9Jej5IQWT/vvdRSg2ODjWOdJk=;
        b=TwMTLLG3me+6Sg8r9KzAw3vs//uRWLiavwh505y8lAjEOIiaIGByXgXAL4Z+MKCk8N
         bDABGLNecA+E7usi3aMJVq0li6++X/a72PGjF2nSHekQL/yuKik38uM2Y+dGCL7VEvkr
         alMKR/5h5ikS2cG9sMz+yyMitD32Ln+a8IXSfeZe9YUowQuFaQTSP7iKGrrv94glJqiw
         CibbfxbH+ePYzYDQzzkVEewgEfCOwcmZ8EofYjo/ubV6Lyqw0HtQrGCmjQNC2x3gPAA4
         52tihnlYZOiywZNQtCrcyDaqd2FgJpWc+sBemT0QbetAxt3CDl+jxSO6pt/cjzxFr8Ee
         xIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YtqT5AIkDrwt3Z27J9Jej5IQWT/vvdRSg2ODjWOdJk=;
        b=asLkIrWZqwf4tWQ+CJwnWT11016mEBR3483RkAZy1K374pNoXAfhJOKw6+XsGEmayK
         JEgc+JXXdUfWEPjyq0ALTAfUo5bOR+64J3i/4gTryFmnsKjxbs6pWIAIbFTT7crfVdV6
         v8QlRSPPGJ1iIxLQARZmXcM8WJ62ztB1CPGx2Ds49kAFbIAy9uVNNPQ8MqA8Z0YDx2dh
         XqAEsro4/1tl/3bueB/srE2iTVe/V5rHwFp7qDA+ZRqsXd+M0lVy7yWG6zmaKvEqWvfc
         FHnqBjoymVoADG0345/BsWDYSsj9reQ3P7iqmG8OuTphZ2FCQxrcu7MS238bYltJbDwZ
         qAfQ==
X-Gm-Message-State: ACrzQf0Tw4/W4uI7uIu5oczhharWskyKS9SOyhGT0s8QWTY2iTWl7dYq
        juTqagDfC+GKF2vPCOYeLQY=
X-Google-Smtp-Source: AMsMyM5JAUPIDfI7dP9f91Cbk4eiuoij6AKZSKijYnPZg2Vz8moSr8FAOmJ3C9z2qCNAop7mSXgVog==
X-Received: by 2002:a63:1609:0:b0:45c:7c1c:4e7d with SMTP id w9-20020a631609000000b0045c7c1c4e7dmr22632992pgl.265.1665526136763;
        Tue, 11 Oct 2022 15:08:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6509])
        by smtp.gmail.com with ESMTPSA id d29-20020a634f1d000000b0043a09d5c32bsm191309pgb.74.2022.10.11.15.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 15:08:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Oct 2022 12:08:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ammarfaizi2-block:tj/cgroup/for-next 3/5]
 kernel/cgroup/cgroup.c:6765: warning: expecting prototype for
 cgroup_get_from_fd(). Prototype was for cgroup_v1v2_get_from_fd() instead
Message-ID: <Y0XpdvqGv9iNXuyI@slm.duckdns.org>
References: <202210120440.qmxr3KCs-lkp@intel.com>
 <CAJD7tkZD5zWMaytpnOnGhL9X_+19nhwxWmsy3rz8EheFgqaUbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZD5zWMaytpnOnGhL9X_+19nhwxWmsy3rz8EheFgqaUbg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 01:41:29PM -0700, Yosry Ahmed wrote:
> Ugh I forgot to update this line in the comment. Tejun, is this
> patchable in place or should I send a patch for this?

Hmm... let's do a separate fixup patch.

Thanks.

-- 
tejun
