Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B83C6E7A58
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjDSNK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjDSNK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:10:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F62CC3A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:10:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a6b17d6387so5492915ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681909855; x=1684501855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WbrFtHJg/np4h59JOkTU9Jcy05rerGwnKepqJc+HmLQ=;
        b=k+fuBF+mbFH1Oq6qvSARivYL+AfV/B4rSjzqIGH7Xbv76CDXNsuxJAH6QpntBYDGUF
         gtq0JmMB7eMIOM2BZVNI8CkB9bJLouqCV+ZH1T44rDQo4kp1iSkrRN7hHvkB7Te6CSZv
         JFU69Utt1WDTbcNO3rqpfnvBGFrZqhNpalUKJoF3SbZ/cde3MhKmUfoKzM+3DAzbq8Q9
         WK3S3tiwNe5hwJ0eYCQVOsL3nkaujk+nCvzJMivGGe2YUHIirtcHw9JYvZHojIsvuTfR
         i7MGxJAMlNmvJib2rb2ZYctFOy2O8TYL6ck0NYEdUYE0YAzVrX7wPESFRGKlkVR62dMb
         jlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681909855; x=1684501855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbrFtHJg/np4h59JOkTU9Jcy05rerGwnKepqJc+HmLQ=;
        b=Krd3fh5rI6GimJCoouAusa7VV9jzTsKJ0lSVBaLic0ylkVhs0SMMroZTJfJBKD5IxQ
         Cyyby69T1AR6oKFbc/adxnnfTQa8kxEIeUsMnfM3teWXaNOaiE45sxVMjTnytbjUuDPR
         JiIFfxXF/JfvNb5ODol0tSf5i35moqhA8B/dSfR+InqE1kF8aR+lSrRp1USK2lxkNFay
         deGWEOFIqxWh6o2S0TBMCoeDi3pZmtIfryee3N25IrmR/P82bKFT/lxtAOC92r4k9AC6
         om1n9lllVji7dtOfnW3bi1sK12W+T4nFajTRfEru6QHhWoBbeKhpPoADWgDGqWrXxlhl
         CnhQ==
X-Gm-Message-State: AAQBX9eE7ikI9d6mw77dczuPAIITVKEoiqR67/yO22oKnSnWGEzb1OND
        0hDwRnFFC77N392SEPkixJ5KrQ==
X-Google-Smtp-Source: AKy350Za+Dts70XAby1aukIHI55APncBRabY87KcRrmj7NhuzYlaV7/HtxWCBlFhdrKQm7EXvUFh5g==
X-Received: by 2002:a17:903:2308:b0:19a:a815:2877 with SMTP id d8-20020a170903230800b0019aa8152877mr22055822plh.6.1681909855603;
        Wed, 19 Apr 2023 06:10:55 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090a7c4400b00246b1b4a3ffsm1385931pjl.0.2023.04.19.06.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 06:10:55 -0700 (PDT)
Message-ID: <b0ffa99e-da46-a373-a011-67f8e739eeca@kernel.dk>
Date:   Wed, 19 Apr 2023 07:10:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] splice: Fix filemap of a blockdev
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Ayush Jain <ayush.jain3@amd.com>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Steve French <stfrench@microsoft.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <168190833944.417103.14222689199936898089.b4-ty@kernel.dk>
 <1770755.1681894451@warthog.procyon.org.uk>
 <1828932.1681909055@warthog.procyon.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1828932.1681909055@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/23 6:57 AM, David Howells wrote:
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> [1/1] splice: Fix filemap of a blockdev
> 
> Actually, would you be able to fix the subject?  I left a word out:
> 
> 	splice: Fix filemap splice of a blockdev
> 
> or maybe:
> 
> 	splice: Fix buffered splice of a blockdev

Fixed it up.

-- 
Jens Axboe


