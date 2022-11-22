Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B42634A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbiKVWq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiKVWqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:46:16 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBC0CB6A5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:46:09 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id io19so15029987plb.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bTnQ+bjlSRBYnNc4zu8793nlHdv3IIshqdtcx+1QmIQ=;
        b=qed//fio4a4zuR200k8iaqnaJl0/IbeC+v5fXU/2WfCYnUANDIksdcOFmljsAl4tFg
         M4iDBiLmlBK3HitI/1apWi08PgMlLw8ueIMYgO48IkDk+jORSq/St8MhmnChtJDiCN4U
         d+D0l13X23ZiLhFifx/q1E5XRdWRtoJngKOkeh0jAuvh4gF0OB4jDBm0LRhHQl6QGwi8
         27Nud7TIR4TfpA4J8vVefdE2CmhqHc85yXHcY3N15pwQJgwqU52ZIIxmNQ5f/KjfkAL+
         D2hq2rtxkTMFVumLZYQke6QlJHIsntNgOLdfALIq7HrhierxnK5Y+hI6Wc9Le9xhEFNP
         BTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTnQ+bjlSRBYnNc4zu8793nlHdv3IIshqdtcx+1QmIQ=;
        b=d72i46b0qag7oDLsCB6le6vxHI5HJcAfu5W6tcvazmfzxLp1wz7jTYVijmeCxSRmlg
         QGLL9NNi9iGHmpiMNHp8i89gV07JiVysU4lT6I9gHKnQ8+03tHONatXOCcJI6D9/u5bk
         /u/lQ1rKpfDzxfRwH9cT4ux/+baY5t37+WhNmsG8J1n7zwKCLR5RkbDDBV/RU2LDZ4pu
         O0UMVrfwFLvFSUWKE8eyLfaJ5pFfIbF3NN1bymdhAP9U2ieU+tBIty2WgLGRKxl6TNmX
         bh+DvC1ZdAot07WyGZUJYzYe1HWBiDG9ROSBw/EOea4+nzzoyUolZb4PwpFvbYH7n+aq
         7RTQ==
X-Gm-Message-State: ANoB5pkWjPDhhxYcYFpIuBLbELFofjpllxyDBUtqU7CIx2242v7+7I2E
        rA6ZQwfcs1DhXYfpm7ZHXDCOXw==
X-Google-Smtp-Source: AA0mqf6j/s0Ch1hxBqkXbIljq6+TZAgAFPLrl8oPPCZ0TYhH880WxKTpPOOwjGNPKpk2Ryh08Tjr8A==
X-Received: by 2002:a17:902:e8d5:b0:186:a636:b135 with SMTP id v21-20020a170902e8d500b00186a636b135mr18737290plg.93.1669157168463;
        Tue, 22 Nov 2022 14:46:08 -0800 (PST)
Received: from localhost ([75.172.139.56])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902680900b001769206a766sm12404202plk.307.2022.11.22.14.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 14:46:08 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Nicolas Frayer <nfrayer@baylibre.com>, nm@ti.com,
        kristo@kernel.org, ssantosh@kernel.org,
        linux-arm-kernel@lists.infradead.org, jassisinghbrar@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     glaroque@baylibre.com, nfrayer@baylibre.com
Subject: Re: [PATCH 0/3] arm64: arch_k3: Removed ti mailbox and sci select
In-Reply-To: <20221122202245.449198-1-nfrayer@baylibre.com>
References: <20221122202245.449198-1-nfrayer@baylibre.com>
Date:   Tue, 22 Nov 2022 14:46:07 -0800
Message-ID: <7h4juqa9qo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Frayer <nfrayer@baylibre.com> writes:

> Removing the automatic selection of the TI message manager and the
> TI sci protocol drivers from ARCH_K3 to allow module build support.
> Set these 2 drivers as ARCH_K3 for the default selection.
> Tested on a TI AM62x SK board.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

In the future, please include linux-omap@vger.kernel.org list, which is
where more developers for these K3 platforms hang out and you might get
more review & testing.

Thanks,

Kevin
