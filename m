Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653916EECC2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 05:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbjDZDcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 23:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239185AbjDZDcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 23:32:02 -0400
Received: from ubuntu20 (unknown [193.203.214.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C911BE6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 20:31:45 -0700 (PDT)
Received: by ubuntu20 (Postfix, from userid 1003)
        id 8B592E1CFB; Wed, 26 Apr 2023 11:31:44 +0800 (CST)
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     mingo@redhat.com
Cc:     surenb@google.com, hannes@cmpxchg.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn,
        peterz@infradead.org
Subject: Re: [PATCH linux-next] sched/psi: avoid unnecessary resetting min update period when destroy trigger
Date:   Wed, 26 Apr 2023 11:31:44 +0800
Message-Id: <20230426033144.15106-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJuCfpFiW7z01FTC2q3hR+h=MhWLwKj96U+MF3s_FjX-9JEqfw@mail.gmail.com>
References: <CAJuCfpFiW7z01FTC2q3hR+h=MhWLwKj96U+MF3s_FjX-9JEqfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_NON_FQDN_1,
        HEADER_FROM_DIFFERENT_DOMAINS,HELO_NO_DOMAIN,NO_DNS_FOR_FROM,
        RCVD_IN_PBL,RDNS_NONE,SPF_SOFTFAIL,SPOOFED_FREEMAIL_NO_RDNS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Apr 17, 2023 at 1:12 AM <yang.yang29@zte.com.cn> wrote:
>>
>> From: Yang Yang <yang.yang19@zte.com.cn>
>>
>> Psi_group's poll_min_period is determined by the min window size of
>> psi_trigger when creating new triggers. While destroying a psi_trigger,
>> there is no need to reset poll_min_period if the destroying psi_trigger
>> not had the min windows size, since in this condition poll_min_period
>> will keep the same as before.
>
> Nice optimization.
>
>>
>> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
>
> Acked-by: Suren Baghdasaryan <surenb@google.com>

Hi, would you please take a review?
Thanks!
