Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB25473F2CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 05:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjF0DcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 23:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjF0Dbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:31:47 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A1F1FC8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 20:27:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8839637D39;
        Mon, 26 Jun 2023 23:27:47 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=message-id
        :date:mime-version:reply-to:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=sasl; bh=
        nOFw18hjIx2H9K031iW9g3K/aJNhzdoHuWqJmcYeJEU=; b=dpPZjvYmIs9M5pLX
        UPjHw5QW57j3dBaHj6A8O+lfZxFdLiTTHXrK7nf9qQRhhM82JrM4mdDkydbwCAm8
        tQWdkJnRu2TgCqP2/+2N8Xbl4bJ4fIlQfEFMUIWVPGR2RXzSi1XOvGo6oqBW4iwa
        erK2s4lxpH3s/E3G/yPIkp7So7M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 80D1F37D38;
        Mon, 26 Jun 2023 23:27:47 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=message-id:date:mime-version:reply-to:subject:to:cc:references:from:in-reply-to:content-type:content-transfer-encoding; s=2019-09.pbsmtp; bh=nOFw18hjIx2H9K031iW9g3K/aJNhzdoHuWqJmcYeJEU=; b=hL9uOQu40nw8MNR6fga7rPXpJyAW+HK64jNEAGo2Sm349rbIwNbFkjBWDwqpwz9kEpoeJ9Tagc9Vt1fhDvoYBzbJ+/ZBfz+WF64ALXBBeh5TemOc9Kj0O9N00R8m+/2TqEf9LuQFtq1bdBwB+nz5cAk/hf2kifp/tFpKMIAJN9A=
Received: from [192.168.1.112] (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8A7FC37D37;
        Mon, 26 Jun 2023 23:27:44 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Message-ID: <1cc88867-f747-2817-077e-c3c6258855c8@darkphysics.net>
Date:   Mon, 26 Jun 2023 20:27:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: tdavies@darkphysics.net
Subject: Re: [PATCH] staging: rtl8192e: Rename function IsHTHalfNmodeAPs to
 is_ht_half_nmode_a_ps
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        gregkh@linuxfoundation.org, dan.carpenter@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <ZJdz9oWjPuE3xZ8Y@tacos.darkphysics>
 <ca4d6bdf-158b-1d5a-da1f-9401d9d95931@gmail.com>
Content-Language: en-US
From:   Tree Davies <tdavies@darkphysics.net>
In-Reply-To: <ca4d6bdf-158b-1d5a-da1f-9401d9d95931@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: 94A5B846-149A-11EE-A06A-B31D44D1D7AA-45285927!pb-smtp21.pobox.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/25/23 07:28, Philipp Hortmann wrote:
> On 6/25/23 00:53, Tree Davies wrote:
>> Rename function IsHTHalfNmodeAPs to is_ht_half_nmode_a_ps in order to
>> fix checkpatch warning: Avoid CamelCase
>>
>
> Hi Tree
>
> If you look where the function is used you will see that it is used in 
> rtllib_rx_auth_resp which is used in:
> rtllib_rx_auth which is used in:
> rtllib_rx_frame_softmac which is used in:
> rtllib_rx_frame_mgmt which is used in:
> rtllib_rx_InfraAdhoc
>
>
> This has for me to do with access points so please do not cut the ap 
> apart.
>
> Thanks
>
> Bye Philipp
>
>
>
Thanks Philip,
I will send a v2
Cheers!
Tree


