Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048896AB96B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCFJNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjCFJNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:13:48 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C38CA1E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:13:47 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a25so35772582edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 01:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678094026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fF1pLE6MLalezdRHlayTB3V70cyFMdizZYI29UXUL0g=;
        b=eUGDW7VzfYhZEVoGV3JVqkjAFiXZV4MbcZQGrDgRRZwAgEPeeaenubo/KSmQRxQ2nX
         SVtjeQLLwNRIedWhHGMX0ctjuCO41TStYJen5OCCzZASGvZUgiUh0RJafGemKLpOjIRG
         YDDU8/ffC0hc0E0m0sX1ODKNhCjp2/y2mz1u7wDxDbKY8y8+WAZtjgXqDv5lMw2O8uZW
         i3mSK68AeahgoLJ0q8Z5AhmMWztrGOODL3sA22vCGsm+v86iOQyELHssvdWUTX9rfvHf
         k8ZsKDPmj0Mr7AGkhm0ViFCc8HB/ssTmpoIBKE93jPkWxGaUELI8OJCO2gy90g6jVNGd
         5mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678094026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fF1pLE6MLalezdRHlayTB3V70cyFMdizZYI29UXUL0g=;
        b=twVEVCkH13qNZgXZY5lRs/HsVq/oMWBJOIZ7YhO68d+yDIeH5LPkZts8dTH1LUYAmI
         8GOKG3gGEB4HdlxqGB51w9KxS0ksQznUzgo+6ngQIx6rFF97o3L278RhzLJ1YLeFToQX
         PbrKr+bsZk0UNwbSVxY698BPnN11+rwdah6Gc6zKFoY5EswcFJUye9N/MQg0teh40M/P
         gkETCMXIc+CwvRgkZ2OcLpRvp7FJ35S6foIjb0WWlVnH2AYxzPwc0B3DesrPWWqagvpC
         CnNfBm35QO+Nu8nJ9x8Ah0xLuTjmSkPtSBxEy3c8pmNh+jG/UMfKVhRGEzRqwMDgXN0c
         2l4A==
X-Gm-Message-State: AO0yUKUFiX9tnEKy8w+kJZBVbVPz8Ssgb2PmZESz/psVxSKlOpGhKsW7
        PJ3kiQaOLirwMXWtUkNoheI=
X-Google-Smtp-Source: AK7set9P7Xp90TDbuIGvAc1neOTW5OolV/ezDUsJGW/fblOfR/k33lyMgNGaPW8I5e3xG/rvDPFMuw==
X-Received: by 2002:a05:6402:384:b0:4af:6aa6:12d3 with SMTP id o4-20020a056402038400b004af6aa612d3mr7674547edv.40.1678094026128;
        Mon, 06 Mar 2023 01:13:46 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x20-20020a50d614000000b004aeeb476c5bsm4127705edi.24.2023.03.06.01.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 01:13:45 -0800 (PST)
Date:   Mon, 6 Mar 2023 12:13:42 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: rtl8192e: Remove empty Array
 Rtl8192PciERadioD_Array
Message-ID: <549c5cc4-8acd-4894-893e-f8cc81ef1458@kili.mountain>
References: <cover.1678051460.git.philipp.g.hortmann@gmail.com>
 <e8842422d34fd19592047ad821c0dbe2eb4bcdc9.1678051461.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8842422d34fd19592047ad821c0dbe2eb4bcdc9.1678051461.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 11:33:18PM +0100, Philipp Hortmann wrote:
> Remove empty array Rtl8192PciERadioD_Array and the code where it is used
> because it is dead code.

It's not really empty.  It has two zeroes in it.

regards,
dan carpenter

