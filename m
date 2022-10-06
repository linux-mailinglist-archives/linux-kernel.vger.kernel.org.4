Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0945F6BC3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJFQ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiJFQ1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:27:48 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A4315E0FD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:27:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so4791505pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 09:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BTSbke7H3945yGqoXvs7Pzts9LsVKZtvClv0i6NPe3Y=;
        b=CkAcks28c7TDgcvW0w7OFQw+19HWYB8Xgh44fexnDpvfnPvPggCp1uWEq+oG3Ka0Gq
         kOUiyFAIEVKY3mddhLBVcsjBr8pdWUwP5NT8dneDjeWzBUpSaIEN5UyakSyUXCKg2lJp
         csQkeNWhXQ+6OSRWYI31vK84iA3KccSDUb+NpDEpnIARf1wzlCW/NoDTawHeRA6i3iB+
         zInF7LymeCv4Bnju3IxPVFp6r6GAUhdeUX1gTSIs9R51jGUJsyRLKjb5UUW0CM6E7CrZ
         q8H3YCLVhMuM14RHWEnop2u/S6EY9ZM8hnbNpAh4xK2WCBPCV6OOJd6KuLqT9Z1NhVZv
         /Qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTSbke7H3945yGqoXvs7Pzts9LsVKZtvClv0i6NPe3Y=;
        b=geY7bHy1PSI/HB0YkCmTFFxTVRL5pzFYlIpnJlko1IVPdcpB/tSQpzzM3s1nUXEbSa
         6Ta41sInF59ltEFtTiJdcpzAS8Kn8zo0Kq4CbM+pXdKNoSH48pnoT5wrRVAwmyQLg7YL
         KSC8TzuN4Z5Q3LcytN8cRRoZFke8JTgDy3aAoip5rSxUczPuNRWbt7riPXHBG+Lv/6KD
         5bFbpDr+ORG060/T+ftb1XQy3MQcphg71FZ6baUmbGYaij58G6ft4kKwlIGLtCDO1n8/
         N6bIkPD5LdBrnMI9+2+vLlJcjZkPQ+V7yxnpbL+LXONYp34bhu7H2dfYdArKbv0C6iKy
         CgUw==
X-Gm-Message-State: ACrzQf0edb31Y4ZXqotZZl1rcN18gtU8nJOWckbPdREWzJf5Fx1ufSlx
        QczUX3wK9T4oFaLN8P08DhycaE0124lC7uGq7H91iU7FGAXRB3u+gc0=
X-Google-Smtp-Source: AMsMyM6NHLmb5ijyzrIRPDNn/O0Cf+CO0cu/DXgUDDtOJVOExxCymN3YzmDC/jFf8wREo+jGdpRiiNV7L5udmaUmNSE=
X-Received: by 2002:a17:902:6807:b0:17f:7fa2:be26 with SMTP id
 h7-20020a170902680700b0017f7fa2be26mr713432plk.34.1665073657837; Thu, 06 Oct
 2022 09:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <1266113f-75a1-b276-bb8c-3cdfcbabf043@alu.unizg.hr> <4c45d359-3e58-05ec-0a40-1ebcf2283af2@gmail.com>
In-Reply-To: <4c45d359-3e58-05ec-0a40-1ebcf2283af2@gmail.com>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Thu, 6 Oct 2022 12:27:26 -0400
Message-ID: <CA+pv=HMbB5NEd1beHq99QUBdHz6iuBn19R4HzF1M_cgdtD4J1A@mail.gmail.com>
Subject: Re: BUG: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3
 through 6.0.0-rc7
To:     Marc Miltenberger <marcmiltenberger@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Marc,

On Thu, Oct 6, 2022 at 6:39 AM Marc Miltenberger
<marcmiltenberger@gmail.com> wrote:
>
> Hi there,
>
> I have probably the same problem on Ubuntu kinetic kudu using
> 6.0.0-060000rc7daily20221002-generic obtained from
> https://kernel.ubuntu.com/~kernel-ppa/mainline/daily/2022-10-02/amd64/

For you specifically, this is more of a thing for Canonical/Ubuntu to
look at. They do their own customizations to their kernel (hence the
extra stuff after the dash) and thus, folks on this list can't do much
for it.

If you were using a compiled kernel from the repository at
git.kernel.org, that'd be different.

Best,
-srw
