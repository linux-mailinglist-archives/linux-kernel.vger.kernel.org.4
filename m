Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266F1607848
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiJUNW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJUNW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:22:56 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379432527E8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:22:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b12so5778935edd.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aTHKaZCiit3Ul01YDGFtP12Qx3iKFThlFmh66angHUc=;
        b=fiKApkDmp6tyrlKol5Kb4NK0cPmQ+F4mux4TjM51jKFVSqtU6Qcoizqk9zF9Af4k2Z
         AKGDRbIELDjq/0ek3b+/CKd+oxjLLIYsqPBU10Uok+k5CHQBv7lsiYRdZDgD1bRcUIaP
         UC9VBncfA7Mi+4PPHP+68gNwVaxFA0p57NuGRrG/4R3Wdb2PSpqrFJxiRMIUBQDUJBdW
         TsTG7SLdkLaoyy5P2famgp01xlnUgT7yVEYfVjcheym6Jl6U6GUU/ruy27ZPy6b328qV
         I9ixf1Q9xGAVdSAAJqyExDRc4TNobtnPbGnlmNp/QxAFiaffbdG06X3xPF0wPavtg7lQ
         TsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTHKaZCiit3Ul01YDGFtP12Qx3iKFThlFmh66angHUc=;
        b=gqXa0yAw2MkJMtGOt3ujDYEJ+8GWSILSsm1cs67MO+b6+8t4nH0fmlBXNtF1q+5lsF
         8+/gkcKMrXmyC55Brn1xAvysLg8VizgqK9WfIttgpQqLPg3NG1mtB1K8tFx8hXnzZZnx
         xVBhtlVUn9PdrtRMnbF/hRMBi9fbWfmZjnApWMrBGRUln6Mi1Xkl5WjKjT2CQg/QaBew
         F61GdkELWm0r5FcdsrSkjSYaaL9NQgpZVTAZsF48X5+10Fy/+9kmFobr+RtMzB6iZSjn
         BMoRitGRgzXsSxOUveFZ0Wf6l6ZukSpSlHmSb5Z7lluju5J9NXkKWyQdZ0z1aqNJ3uv6
         MFJA==
X-Gm-Message-State: ACrzQf0dLf4M5eqnYExcYmO89cy/7VhOxOokMuPfjAG9+G7/4SpfqOe8
        e2K/POimN/kfE4Tqa/cKj0Iy7EB5kmooow==
X-Google-Smtp-Source: AMsMyM5syXbdOdYghEOb2IW3LQ96J2f99FQy3tqIx70r6rE6I/rZ/NQEu6JeomSCSuBNsoX5g4Hi0A==
X-Received: by 2002:a05:6402:28b7:b0:459:3115:aa07 with SMTP id eg55-20020a05640228b700b004593115aa07mr16798195edb.280.1666358573617;
        Fri, 21 Oct 2022 06:22:53 -0700 (PDT)
Received: from andrea ([77.89.52.45])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709061da900b0078e0973d1f5sm10694622ejh.0.2022.10.21.06.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:22:53 -0700 (PDT)
Date:   Fri, 21 Oct 2022 15:22:48 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix race when vmap stack overflow
Message-ID: <Y1KdKATQx16Xl/iL@andrea>
References: <20221019154727.2395-1-jszhang@kernel.org>
 <Y1HZFcBo21SQzXVj@andrea>
 <CAJF2gTRAEX_jQ_w5H05dyafZzHq+P5j05TJ=C+v+OL__GQam4A@mail.gmail.com>
 <Y1JaE/ot91Z0KXuC@andrea>
 <ed7c4027-8e15-245f-cdda-0551063761e7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed7c4027-8e15-245f-cdda-0551063761e7@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tong,
 
> > > I use atomic_set_release here, because I need earlier memory
> > > operations finished to make sure the sp is ready then set the spin
> > > flag.

> 	Consider this implementation:)
> 
> 	smp_store_mb(&spin_shadow_stack, 0);

smp_store_mb() has "WRITE_ONCE(); smp_mb()" semantics; so it doesn't
guarantee that the store to spin_shadow_stack is ordered after program
-order earlier memory accesses.

  Andrea
