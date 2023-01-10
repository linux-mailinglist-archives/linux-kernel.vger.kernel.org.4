Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF96663888
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 06:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjAJFVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 00:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjAJFVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 00:21:02 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4E65FC6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:21:00 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so8920511wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 21:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sNxTDu1tbYQEdXfie9Jbpp3SHUANSK0JEbtFP0ICaTM=;
        b=ZLSOe8ClyEapVdx1yzs1T3U2/SqDyDt3KoGCn2te5FckQ9yAlUhx8qRkLL0pBnzDGS
         ZVJg6Fi841QvWRa5thSZmohxgCJBgFueG+2Qbxz9TrfIOxzeUhL4vdO9uaqV4BiHpomW
         1K7KcKNAkOJlNDOsOEfNuwIzT/HWbGaGKFABdUmz1SmSCkJ1TO8wPV+f+eMDJNYyA9Ha
         frskjLCteUoRNAFL9C1/FmeSjrlMLAYMv4HC/NV4xYXvPk+EEm7HfrjI7ulTo+Bh01Hs
         ixJwgQ2N8xhdbtxnfBbukKHNnnnd8+FsvCGIQnxzXL9UhuVggcAQkoAGQalgADeQWWhi
         cLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNxTDu1tbYQEdXfie9Jbpp3SHUANSK0JEbtFP0ICaTM=;
        b=X1IaI6zGXf6RX7cvHXAQbX8uolWj7dXjPRFRNmBrMIr/UjlrmY/Z8mE3O24CMz4SAf
         Xl14/UmoieHUC98ZKgfYzkI64vdK+p1TieZbjBTu7196hiV1YI6HDQfq0jFajafekhXa
         IMXylK6hUuLu9SQNblYaMU476XjuoWZvjlISU1dbI7KVbhSmDAdbNIEfCk8+ZbE2eVcv
         G9JW2QsTBziKlWr7o4w+cbq7cFJA6cGleRw3MrfeWPal5ElpJq+cFnH8ZbTTM4BHh2Nw
         5lpJePtlmS4N6/M6bJ8s3PeFkQz0qecOiGQMUHFjrpo/0wN4r8a9G6UXAs8RDmcbBsju
         +lZw==
X-Gm-Message-State: AFqh2kqBBurhrvbI00X4Tp675MFoHwTbmsGmoOdgMjFhxnZwP9ieKL1E
        lHYftvsFiaSq/RlD/BESC48=
X-Google-Smtp-Source: AMrXdXs2wO0EkVhPe1wvgzN/fFSh//nzHHbsOOacJjbjhK63xlNvKXiIN7TM5BHXN1erf+2pMrwhaw==
X-Received: by 2002:a05:600c:4b1b:b0:3d2:1d51:2477 with SMTP id i27-20020a05600c4b1b00b003d21d512477mr58588101wmp.11.1673328059261;
        Mon, 09 Jan 2023 21:20:59 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003d98a7aa12csm20277019wmg.16.2023.01.09.21.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:20:58 -0800 (PST)
Date:   Tue, 10 Jan 2023 08:20:46 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] staging: rtl8192e: Rename variables from
 r8192_priv start with ChannelPlan
Message-ID: <Y7z1rj+O0vUUJRM0@kadam>
References: <cover.1673290428.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673290428.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 08:08:15PM +0100, Philipp Hortmann wrote:
> Rename variables to avoid CamelCase which is not accepted by checkpatch.
> 
> Tested with rtl8192e
> Transferred this patch over wlan connection of rtl8192e
> ---
> V1 -> V2: In patch "Rename TSSI_13dBm, Pwr_Track and NumTotalRFPath"
>           Changed TSSI_13dBm to tssi_13dBm instead of tssi_13dbm

Thanks!

regards,
dan carpenter

