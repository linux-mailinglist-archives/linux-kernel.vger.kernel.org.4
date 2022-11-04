Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7476197E1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiKDNa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiKDNaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:30:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790582CDC9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:30:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37FEAB82B68
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2C5C4347C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667568602;
        bh=p7NYPLDiMSVaPBbSaZ1LqtGh/rbhJgrtL9eOGGAj+M4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lU6+h7Gx0xXyF6ybd/DqamBcjsBjmuzmZZUTJA2CA7a4bjEjRGokAXbMWC7CFfUdH
         1vqXbgUMRHEH2blFPZEMqzdnfh9thJXRYsh8+4CNORQk/rMOpO+ZSxQ6bS+BDVfj2w
         4uco7R75uDVj75/vYknOQaAHZB1DlHEOqj+g2cwdnrnDpeiaRa1PmR8evp+HKIPsxf
         R6qJEaO7xOr/620AKBc+8n+ZJYKvaoTHHasL23pHZ9W8f0XeNCBPP4Dq4SaDgwJ59q
         GyYoBJ2zp+ECZyVRCPMOCT+lLXN294hjf1H/vUG2JcfxR0oIrHSe8VCv+TterVV9bQ
         kar8cFFkP/bUg==
Received: by mail-lf1-f45.google.com with SMTP id be13so7428840lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 06:30:02 -0700 (PDT)
X-Gm-Message-State: ACrzQf1F9LsdR3X3bRbtJpneDucNhNewgPkhGtetscE4v1UBBurK9J/1
        c8TpHtNZCW2Pl99KQqce1Q1YzQ2tFg58BNurYEtpGQ==
X-Google-Smtp-Source: AMsMyM4fVdfYp1R3aiGeKK9liCS4g5DR/1+7C7UsfREwCvhk+qrLUh5vo/id7kyOfkxAhkJ6VcHjB4jTgA8ipDDVsm4=
X-Received: by 2002:a05:6512:2209:b0:4a2:6b07:9a97 with SMTP id
 h9-20020a056512220900b004a26b079a97mr12991376lfu.509.1667568600802; Fri, 04
 Nov 2022 06:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221104094016.102049-1-asavkov@redhat.com>
In-Reply-To: <20221104094016.102049-1-asavkov@redhat.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 4 Nov 2022 14:29:49 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4E37F9iyPU0Qux4ZazHMxz0oV=dANOaDNZ4O8cuWVYhg@mail.gmail.com>
Message-ID: <CACYkzJ4E37F9iyPU0Qux4ZazHMxz0oV=dANOaDNZ4O8cuWVYhg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix build-id for liburandom_read.so
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ykaliuta@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 10:41 AM Artem Savkov <asavkov@redhat.com> wrote:
>
> lld produces "fast" style build-ids by default, which is inconsistent
> with ld's "sha1" style. Explicitly specify build-id style to be "sha1"
> when linking liburandom_read.so the same way it is already done for
> urandom_read.
>
> Signed-off-by: Artem Savkov <asavkov@redhat.com>

Acked-by: KP Singh <kpsingh@kernel.org>

This was done in
https://lore.kernel.org/bpf/20200922232140.1994390-1-morbo@google.com
