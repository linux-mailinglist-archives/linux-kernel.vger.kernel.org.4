Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AD871205D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242279AbjEZGmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 02:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242281AbjEZGmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:42:13 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728991A4;
        Thu, 25 May 2023 23:42:07 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id DD07D5C01CC;
        Fri, 26 May 2023 02:42:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 26 May 2023 02:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1685083326; x=1685169726; bh=4ZYCt9+kUn7u5mA/LUEvMBfAr1vNau3JaEE
        IKYiTcMc=; b=M8C8Q+xCFC7R8bbhEcvLfUPEWnGxMEe7OBbMSnfWPvBPmdLO71L
        fADeolEuuMFbF4w5OgAmW3c8dJmUdiwRye9ZmPiIYeqU5nSiwHqvJ8Cwmuz/gQFz
        gmZoWEYzzSqP+fmoyH3Ubfv7p6xvfRzNW1f1xirg8XLAn5R6LuZQwSHAonLUDOek
        81Tht1sPzj9Dgde6UzWtxvgofmw4eabm6nZ+uLWYynDDDKhsSGrmyjk96esiDKiI
        g8AmAiOGOOnnmnMWrAuWKbDjjbQnesfYXiKwWyT+wGpcr1uLe4PSDbSQe8P9XDOy
        A3Kkr0cGrDrvfh482RUdvWY4PkW/YUzRE/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685083326; x=1685169726; bh=4ZYCt9+kUn7u5mA/LUEvMBfAr1vNau3JaEE
        IKYiTcMc=; b=p9nE/kCEXr5DRRL/7HCVLIR1Nb0yy2/uzkO1Kq+fcjXHkcOuebj
        RG39AEmHJ+CuvH7qm/MwzmIWDXcdhyG2WiqYXM2EWA0yVn3Pg2VJo/NtKwZhH2CZ
        2Itm7K0V1NpRE/eWcU9QRd9kZTRTAvd/D2BkQHYkVAuQn43lEv5F3XjAVo+AD1sh
        O60QDcfDQ6lOFWr00qXxskZVOVTK5G8mtmXfw0YgBiHgcXcgX14w4slA3cEbsFEv
        WJPjRhZc3oepNZGUDhL+x+x0KRd1fAlud3KICBM557DklEmNhyjxDFTXsOpibOoR
        qshkLtrqSv3Xig1VyzIs3ptAPVZ9+JxXD0A==
X-ME-Sender: <xms:vlRwZKKmZNTnZS7PJjCUR5se7CC6mHo9jnz37FBboHoe3V2iCFD9Ig>
    <xme:vlRwZCKb3j0-PTaTX_14AOe6hhPJjBXTCoNypHnb18-F1B0XcnFj3RDuBy3TC0znX
    VdaqUmojPbvwUaEpkU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejkedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:vlRwZKvx4M0nQxUdx5DRfnWDJWNjeFSGDAJt5EDPssEbDDcvrmcLMA>
    <xmx:vlRwZPbzbRqQ3Gev3AbhVSboq_nOBIwxwZTsTrHUBnh6xWQpWmslnQ>
    <xmx:vlRwZBaoC4HQmNAIeM6gpsUgfmqFKnAhCNpHrtOMB8FMltXiqva0rg>
    <xmx:vlRwZDn-X3oPUye8FvOkKrKnoytVvuOrfXitNozh13CDrucNYBpPzg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4F6D2B60086; Fri, 26 May 2023 02:42:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <2591bdc4-a198-446c-8bfe-37ea39c51964@app.fastmail.com>
In-Reply-To: <ZHAmYSclm+5QlLcM@bombadil.infradead.org>
References: <20230517131820.936553-1-arnd@kernel.org>
 <ZG2bfsr+LwrxqsUX@bombadil.infradead.org>
 <a3d01d39-3d45-4fdc-8f73-b6c33bcae24b@app.fastmail.com>
 <ZG27pExhUqFpGexM@bombadil.infradead.org>
 <CAPhsuW4ZksuhhXqDNrb4fPqQFVgW+cfpNLGHOWoLoYWjCKZGpA@mail.gmail.com>
 <ZHAmYSclm+5QlLcM@bombadil.infradead.org>
Date:   Fri, 26 May 2023 08:41:45 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Luis Chamberlain" <mcgrof@kernel.org>,
        "Song Liu" <song@kernel.org>
Cc:     "Alan Maguire" <alan.maguire@oracle.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Borislav Petkov" <bp@suse.de>, linux-modules@vger.kernel.org,
        "Zhen Lei" <thunder.leizhen@huawei.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Kees Cook" <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH] kallsyms: remove unused arch_get_kallsym() helper
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023, at 05:24, Luis Chamberlain wrote:
> On Thu, May 25, 2023 at 06:45:35PM -0700, Song Liu wrote:
>> On Wed, May 24, 2023 at 12:24=E2=80=AFAM Luis Chamberlain <mcgrof@ker=
nel.org> wrote:
>>=20
>> This change broke compilation of BPF selftests in modules-next
>> branch:
>>=20
>> progs/bpf_iter_ksym.c:62:13: error: no member named 'pos_arch_end' in
>> 'struct kallsym_iter'
>>         if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
>>              ~~~~  ^
>> progs/bpf_iter_ksym.c:62:35: error: no member named 'pos_arch_end' in
>> 'struct kallsym_iter'
>>         if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
>>                                    ~~~~  ^
>>=20
>> I haven't looked into the proper fix for it yet.
>
> A quick attempt:
>
> Arnd, can you verify?
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c=20
> b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> index 5ddcc46fd886..521267818f4d 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> @@ -59,9 +59,7 @@ int dump_ksym(struct bpf_iter__ksym *ctx)
>  	} else {
>  		BPF_SEQ_PRINTF(seq, "0x%llx %c %s ", value, type, iter->name);
>  	}
> -	if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
> -		BPF_SEQ_PRINTF(seq, "CORE ");
> -	else if (!iter->pos_mod_end || iter->pos_mod_end > iter->pos)
> +	if (!iter->pos_mod_end || iter->pos_mod_end > iter->pos)
>  		BPF_SEQ_PRINTF(seq, "MOD ");
>  	else if (!iter->pos_ftrace_mod_end || iter->pos_ftrace_mod_end >=20
> iter->pos)
>  		BPF_SEQ_PRINTF(seq, "FTRACE_MOD ");

This looks correct to me, but I'm still failing to cross-build
the selftests on my randconfig build setup, so I can't confirm that
this avoids the build failure, and I don't understand the code well
enough to be sure.

      Arnd
