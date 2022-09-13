Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD045B79F6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiIMSq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiIMSps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:45:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DF77CAAF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 11:26:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u9so29564052ejy.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=+4vcZlKpzREQFON7I3NRtdsxMCMWnGu3rOI/laNWbt4=;
        b=QciN0zfyRb35xUNzvFBSmL8EzpfWDydgM74lPVW+GnNB+LNW1PZXI9OOPwF4oN2/yr
         3CC6mXi1GyzgDbrp9hAWbuJq30Jt/paTVim+baw1xrqdAdl3++rVjIkPh7ONLEMuR7FC
         jnsGx4PtWu8iy9h4nIgGm2Gyb8L+HWSFHffndKAkgnmWD6qR+LIs+gRCEQkR18pJTLCQ
         ePHXXqj7YvWsb1XlrzbnWwWqUOTp9Cf+nQugdaxrhbCrnR98kwpbHmQvRgpwnQmTfj3e
         R3hGcPkemDdOSJMBrD90+iV5pmnEzS8dn+SjsNLov0AV2WVYlmgBTGK2Ex6dwHRm1ujU
         HpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+4vcZlKpzREQFON7I3NRtdsxMCMWnGu3rOI/laNWbt4=;
        b=uYvWBYZGdF2v+7Tgj6TFDZyMDmX/Yk6uUw1oyprk5Db4opizKnG2Wvs8/mU+i+FCLI
         aY2re7Pt5puQx60RiIAAVKVqdzR+GWrcsXh9/t272X2GqIS4qzY+T3I0rkRFf3BgtsHv
         CIB0nu3cA9dFZ9fyjFfRJKztwN4fbHVKIOs3bMlR2/R2PCWMwMkMUP7Vj0nJNhRSGelg
         6/P1Tr4IkboH6B7MVtKhrYyIbWkso9UtWBPrmIY1mhjy6RDtkyeUUxpACWJ1t7Y5Fyvt
         vbNIcPEMm1CsVgEyjZS1JBEYhU7JqBgIY6iL6x/wNVDEKwLWhilk7gJyraIE5oJo+n94
         4HlQ==
X-Gm-Message-State: ACgBeo02ILP0a/S2VYGCsw9a0kUbvlmIkuS3KFOmAmc81eSn9Q9OG8Oy
        HOK0/f/ks3E8DLFxuQ4S0FdD9Wt446w=
X-Google-Smtp-Source: AA6agR6c4uaBCmP2TL5hYA26ttL59lAul9rXygyd/r7Eo++BE2qZabt6j78ixh5aykvXSod1dXbKWA==
X-Received: by 2002:a17:906:7094:b0:73d:c95a:e66e with SMTP id b20-20020a170906709400b0073dc95ae66emr22553578ejk.179.1663093566837;
        Tue, 13 Sep 2022 11:26:06 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f3e:6a20:6823:7621:36e:ae26? (p200300c78f3e6a2068237621036eae26.dip0.t-ipconnect.de. [2003:c7:8f3e:6a20:6823:7621:36e:ae26])
        by smtp.gmail.com with ESMTPSA id c2-20020a170906340200b0073cc17cdb92sm6426801ejb.106.2022.09.13.11.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 11:26:06 -0700 (PDT)
Message-ID: <9abac5a2-e070-501d-ceba-f227a081bd4b@gmail.com>
Date:   Tue, 13 Sep 2022 20:26:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 04/12] staging: vt6655: Cleanup and rename function
 MACbSafeSoftwareReset
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1662890990.git.philipp.g.hortmann@gmail.com>
 <540a684266610f7618b3ef6000d4699d065c8e6f.1662890990.git.philipp.g.hortmann@gmail.com>
 <YyBXp9x1LnBkku2g@kadam>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <YyBXp9x1LnBkku2g@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/22 12:12, Dan Carpenter wrote:
> On Sun, Sep 11, 2022 at 12:46:04PM +0200, Philipp Hortmann wrote:
>> Rename function MACbSafeSoftwareReset to vt6655_mac_save_soft_reset and
>> abyTmpRegData to tmp_reg_data to avoid CamelCase which is not accepted by
>> checkpatch.pl. Remove return value bRetVal as it is unused by the calling
>> functions.
> Please don't mix this kind of stuff into a patch like this.
> 

In the past Greg let me know that I used to many patches for a change in 
the same lines of code and that it would be easier for him to review 
when less patches do the same.

As you wrote I am changing to many things at once. Sorry for breaking 
your automatism.

I will consider your hints for the next patches.

Thanks

Bye Philipp
