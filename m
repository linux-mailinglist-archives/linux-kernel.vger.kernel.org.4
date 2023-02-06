Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCAA68B331
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 01:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBFAVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 19:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBFAVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 19:21:06 -0500
Received: from omta35.uswest2.a.cloudfilter.net (omta35.uswest2.a.cloudfilter.net [35.89.44.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB00411E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 16:21:03 -0800 (PST)
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
        by cmsmtp with ESMTP
        id Onu7pFhMnE9lPOpFnpWcAJ; Mon, 06 Feb 2023 00:21:03 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id OpFmpFwx5aJ3DOpFmpzAFd; Mon, 06 Feb 2023 00:21:02 +0000
X-Authority-Analysis: v=2.4 cv=RqfWkQqK c=1 sm=1 tr=0 ts=63e047ee
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=wTog8WU66it3cfrESHnF4A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=m04uMKEZRckA:10
 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8
 a=3VMw-uIDAAAA:8 a=2V8y8DYtvpxLzc8z7PkA:9 a=QEXdDO2ut3YA:10 a=3IOs8h2EC4YA:10
 a=_FVE-zBwftR9WsbkzFJk:22 a=AjGcO6oz07-iQ99wixmX:22 a=l4yDiZqTIPtlLW9rkt-Q:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LoJqPL0J9HyvZgjS2eI/n1Okuq4m2LvX7JltIBhvybU=; b=Hcn/dREneTNq87d5GwkQMiCb/J
        t3P8cuxt+jWK+UBldA5w2BSGw9q1y+9dkYvVv9bibYi8A93E7mOzPOwnf5D2Wu3d+PAcvddcV/YV1
        DZGgFJtvGbMGnC58Hecg1VZe+BVvFzC2BQmbynIUGV2IikJiKvgKbCKyTf9rU4caMd6/zxYDZhfzi
        plIatiAc11oLF4e4WxQqIFbgtF2fDu0dFUDu1KAqE2son2Q+BWFaKiRRMqu/mtcuq/xkd2LfmWNcG
        WQ1oa/3F2ktJ3SRSIdXfGtumYHlgFRZgxKm6hqkzvx6/zEVR/EGpd5ycYxUxFx21l2KoJsnN0Pgrm
        1KtvqWgQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:50220 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1pOpFl-002yY7-KS;
        Sun, 05 Feb 2023 18:21:01 -0600
Message-ID: <edd631aa-9f12-fe45-e381-f75c384861e9@embeddedor.com>
Date:   Sun, 5 Feb 2023 18:21:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH][next] xfs: Replace one-element arrays with flexible-array
 members
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <Y9xiYmVLRIKdpJcC@work>
 <20230205225119.GU360264@dread.disaster.area>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230205225119.GU360264@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1pOpFl-002yY7-KS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.7]) [187.162.31.110]:50220
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCso9OK6SsF9LN/Rw4rbfGuX7Hn29G9tYXxnonUPiEQfaehumHaLULd6+gUR8FrY38uMpiJ5FnELh4IMuaAktknclTa+Q09Gjhp+nqN5yPZulVnxcAvT
 SbEHZUtAJvAruLJwOPwAXGPlb6OnXKHH5BlapS7MyQP++pz96Khx8l+auCoG016AJc2YtlILeGOtxBcY2YElBrZGjgCJCEvHj6vBNyxRMjiAty6y4tNXmwrC
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/23 16:51, Dave Chinner wrote:
> On Thu, Feb 02, 2023 at 07:24:50PM -0600, Gustavo A. R. Silva wrote:
>> One-element arrays are deprecated, and we are replacing them with flexible
>> array members instead. So, replace one-element arrays with flexible-array
>> members in structures xfs_attr_leaf_name_local and
>> xfs_attr_leaf_name_remote.
>>
>> The only binary differences reported after the changes are all like
>> these:
>>
>> fs/xfs/libxfs/xfs_attr_leaf.o
>> _@@ -435,7 +435,7 @@
>>        3b8:      movzbl 0x2(%rbx),%eax
>>        3bc:      rol    $0x8,%bp
>>        3c0:      movzwl %bp,%ebp
>> -     3c3:      lea    0x2(%rax,%rbp,1),%ebx
>> +     3c3:      lea    0x3(%rax,%rbp,1),%ebx
>>        3c7:      call   3cc <xfs_attr_leaf_entsize+0x8c>
>>                          3c8: R_X86_64_PLT32     __tsan_func_exit-0x4
>>        3cc:      or     $0x3,%ebx
>> _@@ -454,7 +454,7 @@
>>        3ea:      movzbl 0x8(%rbx),%ebx
>>        3ee:      call   3f3 <xfs_attr_leaf_entsize+0xb3>
>>                          3ef: R_X86_64_PLT32     __tsan_func_exit-0x4
>> -     3f3:      add    $0xa,%ebx
>> +     3f3:      add    $0xb,%ebx
>>        3f6:      or     $0x3,%ebx
>>        3f9:      add    $0x1,%ebx
>>        3fc:      mov    %ebx,%eax
>>
>> similar changes in fs/xfs/scrub/attr.o and fs/xfs/xfs.o object files.
> 
> That seems like a red flag to me - an off-by-one change in the
> compiled code that calculates of the on-disk size of a structure as
> a result of an in-memory structure change just smells like a bug.

Ughh..

You're right. I somehow got confused between the moment I first
build-tested this in my build machine and after a final last-minute
review I did on the machine from which I ultimately send the patches
out.

More comments below...

> 
> How did you test this change?
> 
>> And the reason for this is because of the round_up() macro called in
>> functions xfs_attr_leaf_entsize_remote() and xfs_attr_leaf_entsize_local(),
>> which is compensanting for the one-byte reduction in size (due to the
>> flex-array transformation) of structures xfs_attr_leaf_name_remote and
>> xfs_attr_leaf_name_local. So, sizes remain the same before and after
>> changes.
> 
> I'm not sure that is true. Before this change:

Yeah; this in fact was a final last-minute review I did before sending out
the patch, and it was when I noticed the round_up() macro was doing something
quite idiomatic when it comes to calculating the sizes of structures containing
one-element arrays. People usually subtract the sizeof(type-of-one-element)
from the sizeof(struct-with-one-element-array) when they perform other
calculations. And in this case as the sizeof(type-of-one-element) is one byte,
at the moment I thought that subtraction was because of that, and then when I
build-tested that final change, I totally forgot about the padding (I had
actually noticed it when I modified the structure definitions :/) and now I
see I got all confused.

> 
> sizeof(xfs_attr_leaf_name_local_t) = 4
> sizeof(xfs_attr_leaf_name_remote_t) = 12
> 
> After this change:
> 
> sizeof(xfs_attr_leaf_name_local_t) = 4
> sizeof(xfs_attr_leaf_name_remote_t) = 12

Yes; in fact I noticed that. :/

> 
> i.e. no change because the structures aren't defined as packed
> structures.  Hence the compiler pads them to out to 4 byte alignment
> naturally regardless of the flex array definition. pahole on x86-64
> also confirms that the (padded) size of the structure is not
> changed.

Yep; I actually was going to include the pahole output for both structures
in the changelog text, but I decided not to do it at the last minute as
I didn't see it necessary because, as you pointed out, the sizes before
and after the flex-array transformations are the same.

> 
> However, the on-disk structure it is being used to decode is packed,
> and we're only using pointer arithmetic to pull the location of the
> name/value pairs out of the buffer to copy them - it's the structure
> size calculations that actually define the size of the structures
> for a given name length, not the sizeof() value or the flex array
> definitions...
> 
>> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
>> routines on memcpy() and help us make progress towards globally
>> enabling -fstrict-flex-arrays=3 [1].
>>
>> Link: https://github.com/KSPP/linux/issues/79
>> Link: https://github.com/KSPP/linux/issues/251
>> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   fs/xfs/libxfs/xfs_da_format.h | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
>> index 25e2841084e1..e1e62ebb0c44 100644
>> --- a/fs/xfs/libxfs/xfs_da_format.h
>> +++ b/fs/xfs/libxfs/xfs_da_format.h
>> @@ -620,14 +620,14 @@ typedef struct xfs_attr_leaf_entry {	/* sorted on key, not name */
>>   typedef struct xfs_attr_leaf_name_local {
>>   	__be16	valuelen;		/* number of bytes in value */
>>   	__u8	namelen;		/* length of name bytes */
>> -	__u8	nameval[1];		/* name/value bytes */
>> +	__u8	nameval[];		/* name/value bytes */
>>   } xfs_attr_leaf_name_local_t;
>>   
>>   typedef struct xfs_attr_leaf_name_remote {
>>   	__be32	valueblk;		/* block number of value bytes */
>>   	__be32	valuelen;		/* number of bytes in value */
>>   	__u8	namelen;		/* length of name bytes */
>> -	__u8	name[1];		/* name bytes */
>> +	__u8	name[];			/* name bytes */
>>   } xfs_attr_leaf_name_remote_t;
>>   
>>   typedef struct xfs_attr_leafblock {
>> @@ -747,13 +747,13 @@ xfs_attr3_leaf_name_local(xfs_attr_leafblock_t *leafp, int idx)
>>    */
>>   static inline int xfs_attr_leaf_entsize_remote(int nlen)
>>   {
>> -	return round_up(sizeof(struct xfs_attr_leaf_name_remote) - 1 +
>> +	return round_up(sizeof(struct xfs_attr_leaf_name_remote) +
>>   			nlen, XFS_ATTR_LEAF_NAME_ALIGN);
>>   }
> 
> To be honest, the actual padding and alignment calculations are
> kinda whacky because that's the way they were defined back in 1995.
> And, well, once set in the on-disk format, it can't easily be
> changed. FYI, here's the original definition from 1995:
> 
> #define XFS_ATTR_LEAF_ENTSIZE_REMOTE(nlen)	/* space for remote struct */ \
> 	(((sizeof(xfs_attr_leaf_name_remote_t)-1 + (nlen)) +3)&~0x3)
> 
> So apart using round_up and defines instead of magic numbers, the
> current calculation is unchanged from the original definition.
> 
> AFAICT, the modification you are proposing above breaks this because the
> sizeof(xfs_attr_leaf_name_remote) result has not changed with the
> change of the structure definition.
> 
> e.g. if namelen = 17, before we had:
> 
> 	size	= round_up(12 - 1 + 17, 4)
> 		= round_up(28, 4)
> 		= 28
> 
> Which is correct because the on-disk format is packed:
> 
>          0   4   89  12      20   26 28
> 	+---+---++--+-------+-----+-+-----....
>                    |---------------| 17 bytes of name.
> 		                  |-| 2 bytes of padding
> 				    |-----.... Next attr record.
> 
> We end up with 2 bytes of padded between the end of the name and the
> start of the next attribute record in the block.
> 
> But after this patch, now we calculate the size as:
> 
> 	size	= round_up(12 + 17, 4)
> 		= round_up(29, 4)
> 		= 32
> 
> Which is a different result, and would result in incorrect parsing
> of the attribute records in the buffer. Hence I don't think it is
> valid to be changing the entsize calculations like this if sizeof()
> is not changing results.

Yep; you're right.

> 
> Which comes back to my original question: how did you test this?

I compared the generated object files in fs/xfs/, fs/xfs/scrub/ and
fs/xfs/libxfs/ before and after the changes with something like
these[1]:

ARGS=--disassemble --demangle --reloc --no-show-raw-insn --section=.text
for i in $(cd $OUT/xfs/before && echo *.o); do  echo $i; diff -u <(objdump $ARGS $OUT/xfs/before/$i | sed "0,/^Disassembly/d") <(objdump $ARGS $OUT/xfs/after/$i 
| sed "0,/^Disassembly/d"); done

where of course the generated object files before the changes are
located in OUT/xfs/before/ and the ones after changes in $OUT/xfs/after/

I just double-checked and, indeed, the changes I mentioned in the
changelog text only show up when I modify the entsize functions.

So, because of the padding, the flex-array transformations don't
actually affect the sizes of the involved structures. So, it seems
that change is enough and is the correct one.

I really appreciate your comments and feedback, Dave. And I'm sorry
for the confusion.

Thank you!
--
Gustavo

[1] https://outflux.net/blog/archives/2022/06/24/finding-binary-differences/
