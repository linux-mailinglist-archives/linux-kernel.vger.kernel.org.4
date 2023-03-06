Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD196AB9B9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCFJZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFJZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:25:51 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E42F20D37
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:25:50 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cy23so35520470edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 01:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678094749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=19sAxqtflWHF9arRFQZiDCDY+sSsYy5IgiKXozUvNWc=;
        b=XAIFhtFfalfv1jt06PcK0s9tK/uMkZAGx4NWp7SYVtqiEqup+UCgEooIrvZqj+aR/d
         NsEoErqlgzQj2XvTNVjmGv4Tx0lHn6Eq8fUpOIEWr5x4csPmSEXk/984Cx7X7htmsTtK
         ttDVJRkxup9bN15qciDmktmnPyquzhmRLf5m/WrtQpMsQpPxmqDe5w11gQksPQ0NH4Wg
         /SDJWEk2fd3jOkn1YqLShMM2Vv/BVCNIgYHfE0BMooQ2ADvcabzBxrHtV54jBfjYEfZ9
         NM2kUzIGAwvDGOJF6Bjenu/AyZFOn39F+Kfj0luELZRnrvxXykM6MvtZ9x1BfbTED+MH
         nKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678094749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19sAxqtflWHF9arRFQZiDCDY+sSsYy5IgiKXozUvNWc=;
        b=UsOxcx1M/NtFz1hkjQ3tlml3lpJIGFJm3gLlH9ViZ5Ti5RhspMsXZ9qvnJfjsMlBkp
         KdeGdEFpMAoYe0mKLCEM2nzLK3GFzJNnpnFhJQLXHVk1AAHFU+1EkH/UVCHxd/QEv3mS
         EYEN962feURTiHda7Y1H8//E3C8xHTh9n0UqTNuzRQmfxiwwJKipMNRU3VvhP6sJhU/s
         oVWVHsni653f6fRm9QZASiuxwhB5yyHU9FybMnczMtZ735sPI/HDy/2N0u4QGoK7kq2W
         RmNCFsrQhVSSkkChOomLcuUHORyUB+1VdoN/zzTxq5lt+9vKd1WaM7jto8a8wH23WMlz
         A0xQ==
X-Gm-Message-State: AO0yUKXLUlIN4DZOMScKWm+rkXxgqd8DHJ/nD2toaJ/lVSEQFNhyWe+C
        RoBTevGCZE4DFsV1t/EUdNU=
X-Google-Smtp-Source: AK7set/2xm/zHA8DT11sDQEJOZHax5hrf8EJTQmQrbtjfC05auLqsv4AzV4RXixlSzy04ghd2KUdxA==
X-Received: by 2002:a17:907:1b1e:b0:8b2:8876:2a11 with SMTP id mp30-20020a1709071b1e00b008b288762a11mr14630779ejc.28.1678094748846;
        Mon, 06 Mar 2023 01:25:48 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bo19-20020a170906d05300b008cae50b0115sm4277958ejb.87.2023.03.06.01.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 01:25:48 -0800 (PST)
Date:   Mon, 6 Mar 2023 12:25:44 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: rtl8192e: Remove empty Array
 Rtl8192PciEPHY_REGArray
Message-ID: <7d3eaf69-8ddb-4b63-ae8c-89b6a34e9493@kili.mountain>
References: <cover.1677955334.git.philipp.g.hortmann@gmail.com>
 <511bd239bf033dca3efcc64a640d5343c98fa897.1677955334.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <511bd239bf033dca3efcc64a640d5343c98fa897.1677955334.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2023 at 08:13:22PM +0100, Philipp Hortmann wrote:
> Remove empty array Rtl8192PciEPHY_REGArray and the code where it is used
> because it is dead code.
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 5 +----
>  drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 2 --
>  drivers/staging/rtl8192e/rtl8192e/table.c      | 2 --
>  drivers/staging/rtl8192e/rtl8192e/table.h      | 2 --

What are these table.[ch] files?  I don't seem to have them.

regards,
dan carpenter

