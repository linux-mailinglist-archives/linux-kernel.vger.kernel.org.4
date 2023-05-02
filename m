Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306CB6F3B77
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 02:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjEBAoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 20:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEBAoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 20:44:12 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BFC2D4A;
        Mon,  1 May 2023 17:44:11 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4efe8991b8aso3939025e87.0;
        Mon, 01 May 2023 17:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682988249; x=1685580249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=saVxUxSMtTajADFZuL/4juBM2ygeaeZkjxGnpRk3u5k=;
        b=Q8xL6WPuRVBFfHqk98yEWnwyUvlpc6Bz1WMdxZa7ltSd5TTW2OzQD2cmNCnVgOrhXf
         LrNfjyk4ZyqolCifiDXYlMID3iym1uOLBs6zxbcc95LgjcLrLnpfybQfcGtIuyrBC5DA
         ecmFdiuoEtitHuydG8uvDPoXTqoMGGtdE3jNWHguIh3FPMnq2tvCvxsSBuLJ4gBLIinc
         jx7xGZp7Q67j05CsaZewUCbzmuEPCARWpxZNVN96qwcBjF4aPhZ8NeSpVLijA6CC9D5B
         pMIl/7ScpnvMHnNbSP4vHc04L001Ko1S3s97twMLu7HxNEPdbsma9ZlOX7Wr346w7Sre
         LGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682988249; x=1685580249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saVxUxSMtTajADFZuL/4juBM2ygeaeZkjxGnpRk3u5k=;
        b=BQEAcgygRLr4cXVhFs0ID4mBedv98ynIVnRR5JbhSqYMZnB5cIhnwW4oayw0vdMT05
         kXyuNenhE9WiDC7i4BdprNMLVhD1h/o8VMZQ8QsZnmLb6Kdm5WNWI6k9mr2pweIXQS8H
         mi9yA2/XpaVOMT/9P0SDZ0Kp/im9gphxKdlofB4LUmyfNLwyky5TX/gI+ub03/qVnfpM
         K2OZmnGGUXhOz40tVudzDsCOyy5k5Yl08ARdbOO0CedICmnzRS+lKTQoswQYFVSKM8G5
         T3s0bSBxN6O53Uet7Nr+OzNgeYcMSlF3AESvOWzr+6TUP/ujjK8amSWO3w4nzWGj6BeC
         ZUsg==
X-Gm-Message-State: AC+VfDyVXrTBXE+5Q6Zl4XPNY059D2KMsJ9Q9b2rVchDZPPYjhcUYhMS
        Vwd6GZFQ/hL+B9wd33Bx+JI=
X-Google-Smtp-Source: ACHHUZ45QG2zy1JU5l49CFw+59KhjXYKiAGxVjy472QgZD45BwPJCE8ZSQ2FYJN1P+u8vSi0Qjb55Q==
X-Received: by 2002:ac2:44c6:0:b0:4f0:304:db95 with SMTP id d6-20020ac244c6000000b004f00304db95mr3613856lfm.22.1682988249082;
        Mon, 01 May 2023 17:44:09 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id z2-20020ac25de2000000b004ec89c94f04sm5007854lfq.155.2023.05.01.17.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 17:44:08 -0700 (PDT)
Date:   Tue, 2 May 2023 03:44:06 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Joy Chakraborty <joychakr@google.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com
Subject: Re: [PATCH v9 0/5] spi: dw: DW SPI DMA Driver updates
Message-ID: <20230502004406.bnkemndaakpxpjji@mobilestation>
References: <20230427123314.1997152-1-joychakr@google.com>
 <20230501171409.syub4ro3kb3r6ho2@mobilestation>
 <ZFBSKd1Z5nUg60s8@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFBSKd1Z5nUg60s8@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 08:58:33AM +0900, Mark Brown wrote:
> On Mon, May 01, 2023 at 08:14:09PM +0300, Serge Semin wrote:
> > @Mark, @Andy
> 
> Just as a note please don't add random characters to the start of the
> name, for whatever reason it really annoys me.

Ok.

> 
> > I've done with reviewing and testing the series. My tags are already
> > added to the patch logs. @Andy do you still have any comments about
> > the updated patchset? If none, @Mark please merge it in if you are ok
> > with the changes.
> 
> We're still in the merge window right now.

Ah, right. I absolutely forgot about that. Sorry for bothering. Let's
wait for the merge window to be closed then.

-Serge(y)
