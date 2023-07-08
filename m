Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F041C74BA58
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 02:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjGHAEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 20:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjGHAEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 20:04:05 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35AC128;
        Fri,  7 Jul 2023 17:04:04 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-564e4656fecso1799003eaf.0;
        Fri, 07 Jul 2023 17:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688774644; x=1691366644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2gdC3PO47cUUQGRt755wn0is46+ghReRgmgWEhUcpQ=;
        b=qhWaLQllCuCGKUMyRlQ4Y3jfzUM8tYjJv5FQUe6vBt8cYiKPVKGfxVMkPq/omRZgDu
         Z7Y+H6AQIlzq8uVWgMa7pQwe7aTzNt74H6C1nJsuwlZ547N7XwveIoerSyBl5uL0gG0w
         ihYM1sljS/YODwRrHx0aaG+koY2In13nkwcgmX9jSrwIeNNEuuwA2ZXJmlzD7JurSlTv
         ZgHLBXqmIYrqqzEA5pKUQp53lHrmafRi/Vln72HkKlFfyXhhyAiCCZmuMceeGp4aKcDO
         Sj7vLW19L5nCWHxY+HRgjBd1Z7oGzBEaLNAjaWqcdx9Mfz5NhLVF4jbEG9Cja79V9CCt
         GZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688774644; x=1691366644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2gdC3PO47cUUQGRt755wn0is46+ghReRgmgWEhUcpQ=;
        b=DVBHLa2VM9ZLdrjDAN5WSVS3Ac0MfYeYdiWCHdQBXI0kv1cdhkrniyme4HT0t4AOTP
         SY6/ta9m0OZJKUCV79Amse9P5aZTJ3l1c2Edbiljs5VVV1WbyDiatVi5b0uECPFq9OZP
         0rYvxwtV77arnscr3Wk4ELQhL2Kn4OpOcLUXRb1wiF9M3AJ1D9opaUW1rY36EGErzsam
         Zk20RsdBiMVCKOI40EPi3JphAIjUoqLm6pZSmo1qnXjtYEwkud0+IKX5VnJnRLW8Y/hH
         DqgcISV9mYQ7uXFqnzZZU6C2xpbaTV8Q49gPywhS0waaa3Sl6Y0AMACo74RbM6fLy/La
         SmMA==
X-Gm-Message-State: ABy/qLaj+tn08DvRfcpnGYD37KMT6ynWL0jg9958uuUf0akdc/lQ1k7A
        SI9b+AufwRGfqbJmXtGtnr0=
X-Google-Smtp-Source: APBJJlF9CPR98MDBMXWpXAPZWBTF0ew9e6in9Db1Nid4ijb6FifisiIXhlWocVa6EDGrLHaiWwTDKA==
X-Received: by 2002:a05:6358:2618:b0:127:f2fb:d103 with SMTP id l24-20020a056358261800b00127f2fbd103mr8955183rwc.16.1688774643932;
        Fri, 07 Jul 2023 17:04:03 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:38de:2bd4:8f55:60cd])
        by smtp.gmail.com with ESMTPSA id ja18-20020a170902efd200b001a69dfd918dsm3773541plb.187.2023.07.07.17.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 17:04:03 -0700 (PDT)
Date:   Fri, 7 Jul 2023 17:04:00 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: pinephone-keyboard - Use
 devm_regulator_get_enable()
Message-ID: <ZKin8MdW8yKEQwlr@google.com>
References: <78d7a4719ed7c372a7aa62afb66d4f1561799b5f.1686985515.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78d7a4719ed7c372a7aa62afb66d4f1561799b5f.1686985515.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 09:05:42AM +0200, Christophe JAILLET wrote:
> Use devm_regulator_get_enable() instead of hand writing it. It saves some
> line of code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thank you.

-- 
Dmitry
